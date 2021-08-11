import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/entity/line/route_real_time_info_entity.dart';
import 'package:weifangbus/entity/line/station_real_time_info_entity.dart';
import 'package:weifangbus/entity/route_stat_data_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/widget/future_common_widget.dart';
import 'package:weifangbus/widget/route_header.dart';

/// 线路详情
class RouteDetail extends StatefulWidget {
  final String title;
  final int routeId;

  const RouteDetail({Key? key, required this.title, required this.routeId})
      : super(key: key);

  @override
  _RouteDetailState createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail>
    with AutomaticKeepAliveClientMixin {
  /// 方便获取 ScaffoldState 进行 showSnackBar
  final _routeDetailKey = GlobalKey<ScaffoldState>();

  /// 换向后的列表重置
  var _listKey = UniqueKey();

  /// 线路详情
  late RouteStatDataEntity _routeStatData;

  /// 线路单向详情
  late RouteStatDataSegmentList _segment;

  /// 换向
  var _index = 0;

  /// 避免重绘
  var _routeStatDataFuture;

  /// 车辆实时信息
  late RouteRealTimeInfoEntity _routeRealTimeInfo;

  /// 获取车辆实时信息必需参数
  var _segmentID;

  /// 车辆、站点实时信息定时器
  late Timer _timer;

  /// 站点实时信息Future
  late Future<StationRealTimeInfoEntity> _stationRealTimeInfoFuture;

  /// 展开的索引
  List<int> _expandIndexList = List.empty();

  /// 站点实时信息数
  int _carInfoCount = 2;

  /// 屏幕方向
  late Orientation _orientation;

  /// 获取线路详情
  Future<RouteStatDataEntity> _getRouteStatData() async {
    try {
      Response response;
      var uri = "/BusService/Require_RouteStatData/?RouteID=" +
          widget.routeId.toString() +
          "&" +
          getSignString();
      // print(uri);
      response = await dio.get(uri);
      List<dynamic> list = response.data;
      // print('${response.data}');
      List<RouteStatDataEntity> routeStatDataEntityList = list
          .map((dynamic) =>
              EntityFactory.generateOBJ<RouteStatDataEntity>(dynamic))
          .toList();
      var routeStatDataEntity = routeStatDataEntityList[0];
      if (routeStatDataEntity == null) {
        routeStatDataEntity = RouteStatDataEntity();
      }
      // 单向信息
      _segment = routeStatDataEntity.segmentlist[_index];
      // 车辆实时信息
      _segmentID = _segment.segmentid.toString();
      _routeRealTimeInfo = await _getRouteRealTimeInfo(_segmentID);
      // 定时刷新
      _refreshRouteRealTimeInfo(_segmentID);
      print('请求线路详情完毕');
      return routeStatDataEntity;
    } on DioError catch (e) {
      print(getErrorMsg(e, msg: "请求线路详情"));
      return Future.error(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _routeStatDataFuture = _getRouteStatData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 定时刷新车辆实时信息
  void _refreshRouteRealTimeInfo(String segmentID) {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      print('定时刷新车辆实时信息 ${DateTime.now()}');
      _immediatelyFlush(segmentID);
      if (_expandIndexList.isNotEmpty) {
        print('定时刷新站点实时信息 ${DateTime.now()}');
        setState(() {
          _stationRealTimeInfoFuture = _getStationRealTimeInfoFuture();
        });
      }
    });
  }

  /// 立即刷新车辆实时信息
  _immediatelyFlush(String segmentID) async {
    var routeRealTimeInfoEntity = await _getRouteRealTimeInfo(segmentID);
    setState(() {
      _routeRealTimeInfo = routeRealTimeInfoEntity;
    });
  }

  /// 展示 SnackBar
  void showSnackBar(String snackStr, VoidCallback onPressed) {
    _routeDetailKey.currentState!.hideCurrentSnackBar();
    _routeDetailKey.currentState!.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(snackStr),
        action: SnackBarAction(label: '重试', onPressed: onPressed),
      ),
    );
  }

  /// 车辆实时信息
  Future<RouteRealTimeInfoEntity> _getRouteRealTimeInfo(
      String segmentID) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        Response response;
        var uri = "/BusService/Query_ByRouteID/?RouteID=" +
            widget.routeId.toString() +
            "&SegmentID=" +
            segmentID +
            "&" +
            getSignString();
        // print('$uri');
        response = await dio.get(uri);
        // print('${response.data}');
        var routeRealTimeInfo =
            JsonConvert.fromJsonAsT<RouteRealTimeInfoEntity>(response.data);
        print('请求车辆实时信息完毕');
        return routeRealTimeInfo;
      } on DioError catch (e) {
        print(getErrorMsg(e, msg: "请求车辆实时信息"));
        if (_routeStatData == null) {
          showSnackBar('啊哦！请求车辆实时信息失败!', () {
            _immediatelyFlush(segmentID);
            if (_expandIndexList.isNotEmpty) {
              print('重试刷新站点实时信息 ${DateTime.now()}');
              setState(() {
                _stationRealTimeInfoFuture = _getStationRealTimeInfoFuture();
              });
            }
          });
        }
        return Future.error(e);
      }
    } else {
      print('木有开网络!!!');
      if (_routeStatData == null) {
        showSnackBar('设备未连接到任何网络,请连接网络后重试!', () {
          _immediatelyFlush(segmentID);
          if (_expandIndexList.isNotEmpty) {
            print('重试刷新站点实时信息 ${DateTime.now()}');
            setState(() {
              _stationRealTimeInfoFuture = _getStationRealTimeInfoFuture();
            });
          }
        });
      }
      return Future.value(null);
    }
  }

  /// 显示车辆实时信息
  Widget carRealInfo(String stationID) {
    var widget;
    // 防止请求失败时构建出现错误
    if (_routeRealTimeInfo != null) {
      _routeRealTimeInfo.rStaRealTInfoList.forEach((element) {
        // print('${element.stationID}');
        if (element.stationID == stationID) {
          // print('找到 ${element.stationID}');
          widget = Container(
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: element.stopBusStaNum != 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              MaterialCommunityIcons.bus_side,
                              color: Colors.green,
                            ),
                            AutoSizeText(
                              S
                                  .of(context)
                                  .ArriveAtStation('${element.stopBusStaNum}'),
                              style: TextStyle(
                                fontSize: _orientation == Orientation.portrait
                                    ? 30.ssp
                                    : 15.ssp,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
                Expanded(
                  child: element.expArriveBusStaNum != 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              MaterialCommunityIcons.bus_side,
                              color: Colors.red,
                            ),
                            AutoSizeText(
                              S.of(context).AwayFromTheStation(
                                  '${element.expArriveBusStaNum}'),
                              style: TextStyle(
                                fontSize: _orientation == Orientation.portrait
                                    ? 30.ssp
                                    : 15.ssp,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          );
        }
      });
    }
    return widget ?? Container();
  }

  /// 获取站点实时信息Future
  Future<StationRealTimeInfoEntity> _getStationRealTimeInfoFuture() async {
    try {
      Response response;
      var uri = "/BusService/Query_ByStationID/?RouteID=" +
          widget.routeId.toString() +
          "&StationID=" +
          _segment.stationlist[_expandIndexList.last].stationid +
          "&" +
          getSignString();
      // print(uri);
      response = await dio.get(uri);
      // print(response.data);
      List<StationRealTimeInfoEntity> routeRealTimeInfoList =
          JsonConvert.fromJsonAsT<List<StationRealTimeInfoEntity>>(
              response.data);
      var routeRealTimeInfo = routeRealTimeInfoList.first;
      print('请求站点实时信息完毕');
      return routeRealTimeInfo;
    } on DioError catch (e) {
      print(getErrorMsg(e, msg: "请求站点实时信息"));
      return Future.error(e);
    }
  }

  /// 站点名称及车辆信息
  ListTile buildListTile(RouteStatDataSegmantlistStationlist e, int i) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${i + 1}'),
      ),
      title: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 6,
            child: AutoSizeText(
              e.stationname,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 5,
            child: carRealInfo(e.stationid),
          ),
        ],
      ),
    );
  }

  /// 车辆实时列表
  Widget buildListView() {
    return _expandIndexList.isNotEmpty
        ? Column(
            children: [
              FutureBuilder<StationRealTimeInfoEntity>(
                future: _stationRealTimeInfoFuture,
                builder: (BuildContext context,
                    AsyncSnapshot<StationRealTimeInfoEntity> snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      var height = 175 * _carInfoCount;
                      return Container(
                        height: height.h,
                        child: Center(
                          child: RaisedButton(
                            color: Colors.blue,
                            highlightColor: Colors.blue[700],
                            colorBrightness: Brightness.dark,
                            splashColor: Colors.grey,
                            child: Text("请检查网络连接后点击重试"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            onPressed: reGetStationRealTimeInfo,
                          ),
                        ),
                      );
                    } else {
                      StationRealTimeInfoEntity stationRealTimeInfo =
                          snapshot.data;
                      var realtimeInfoList =
                          stationRealTimeInfo.realtimeInfoList;
                      _carInfoCount = realtimeInfoList.length;
                      // 请求成功，显示数据
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: realtimeInfoList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              Icons.info_outlined,
                            ),
                            title: AutoSizeText(
                              '${realtimeInfoList[index].busName} ${realtimeInfoList[index].foreCastInfo2}到达',
                            ),
                            subtitle: AutoSizeText(
                              '${realtimeInfoList[index].foreCastInfo1} ${realtimeInfoList[index].arriveStaName}',
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    // 请求未结束，显示loading
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _carInfoCount,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.info_outlined,
                          ),
                          title: AutoSizeText(
                            S.of(context).Loading,
                          ),
                          subtitle: AutoSizeText(
                            S.of(context).Loading,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: buildStationOperation(Colors.green, '电子站牌', () {
              //         print('点击了电子站牌');
              //       }),
              //     ),
              //     Expanded(
              //       child: buildStationOperation(Colors.blue, '收藏本站', () {
              //         print('点击了收藏本站');
              //       }),
              //     ),
              //     Expanded(
              //       child: buildStationOperation(Colors.deepOrange, '刷新', () {
              //         print('点击了刷新');
              //       }),
              //     ),
              //     Expanded(
              //       child: buildStationOperation(Colors.teal, '到站提醒', () {
              //         print('点击了到站提醒');
              //       }),
              //     ),
              //   ],
              // ),
            ],
          )
        : Container();
  }

  // /// 站点操作部分
  // Widget buildStationOperation(
  //     Color color, String label, VoidCallback onPressed) {
  //   return Container(
  //     color: color,
  //     child: FlatButton(
  //       onPressed: onPressed,
  //       child: AutoSizeText(
  //         label,
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // print('界面开始构建');
    super.build(context);
    return Scaffold(
      key: _routeDetailKey,
      appBar: AppBar(
        title: AutoSizeText(
          widget.title,
          maxLines: 2,
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          _orientation = orientation;
          return FutureBuilder<RouteStatDataEntity>(
            future: _routeStatDataFuture,
            builder: (BuildContext context,
                AsyncSnapshot<RouteStatDataEntity> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return noneWidget(context);
                  break;
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return activeOrWaitingWidget();
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return RetryWidget(
                      onPressed: reTry,
                    );
                  } else if (snapshot.hasData) {
                    // 请求成功，显示数据
                    _routeStatData = snapshot.data;
                    var length = _routeStatData.segmentlist.length;
                    var stationList = _segment.stationlist;

                    // 展开内容,唯一一个，不然每个条目都会构建
                    var carInfo = buildListView();

                    // 站点面板列表
                    List<ExpansionPanelRadio> expansionPanelRadios = List.empty();
                    for (var i = 0; i < stationList.length; ++i) {
                      var e = stationList[i];
                      var expansionPanelRadio = ExpansionPanelRadio(
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return buildListTile(e, i);
                        },
                        body: carInfo,
                        value: e.stationid,
                      );
                      expansionPanelRadios.add(expansionPanelRadio);
                    }

                    // 站点列表
                    return Column(
                      children: [
                        // 头部信息
                        RouteHeader(
                          routeName: _routeStatData.routename,
                          firstStationName: stationList.first.stationname,
                          lastStationName: stationList.last.stationname,
                          transDirection: length > 1,
                          transDirectionFun: () {
                            // 换向提示
                            _routeDetailKey.currentState!.hideCurrentSnackBar();
                            _routeDetailKey.currentState!.showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text(
                                  S.of(context).ReversingComplete,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            setState(() {
                              print('换向');
                              _index == 0 ? _index = 1 : _index = 0;
                              _segment = _routeStatData.segmentlist[_index];
                              _segmentID = _segment.segmentid.toString();
                              _timer?.cancel();
                              _immediatelyFlush(_segmentID);
                              _refreshRouteRealTimeInfo(_segmentID);
                              _expandIndexList = List.empty();
                              _carInfoCount = 2;
                              _listKey = UniqueKey();
                            });
                          },
                          firstAndLastBus: _segment.firtlastshiftinfo,
                          routePrice: _segment.routeprice,
                          orientation: _orientation,
                        ),
                        // 站点列表
                        Expanded(
                          child: SingleChildScrollView(
                            key: _listKey,
                            child: ExpansionPanelList.radio(
                              expansionCallback: (int index, bool isExpanded) {
                                // 使得能够正确获取到展开面板的索引
                                if (_expandIndexList.contains(index)) {
                                  _expandIndexList.remove(index);
                                } else {
                                  _expandIndexList.add(index);
                                  setState(() {
                                    _stationRealTimeInfoFuture =
                                        _getStationRealTimeInfoFuture();
                                  });
                                }
                              },
                              children: expansionPanelRadios,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // return Text('返回了个寂寞');
                    return RetryWidget(
                      onPressed: reTry,
                    );
                  }
                  break;
                default:
                  return Text('啥也木有,哈哈哈');
              }
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   label: Text('更多'),
      //   icon: Icon(Icons.add),
      //   backgroundColor: Colors.green,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// 重试
  void reTry() {
    setState(() {
      _routeStatDataFuture = _getRouteStatData();
    });
  }

  /// 重新加载站点实时信息
  void reGetStationRealTimeInfo() {
    setState(() {
      _stationRealTimeInfoFuture = _getStationRealTimeInfoFuture();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
