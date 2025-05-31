import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:weifangbus/api/ApiService.dart';
import 'package:weifangbus/entity/route_real_time_info_entity.dart';
import 'package:weifangbus/entity/route_station_data_entity.dart';
import 'package:weifangbus/entity/station_real_time_info_entity.dart';
import 'package:weifangbus/view/home/line/route_header.dart';

/// 线路详情
class RouteDetail extends StatefulWidget {
  final String title;
  final int routeId;

  const RouteDetail({Key? key, required this.title, required this.routeId}) : super(key: key);

  @override
  _RouteDetailState createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> with AutomaticKeepAliveClientMixin {
  /// 方便获取 ScaffoldState 进行 showSnackBar
  final _routeDetailKey = GlobalKey<ScaffoldState>();

  /// 换向后的列表重置
  var _listKey = UniqueKey();

  /// 线路详情
  late RouteStationDataEntity _routeStatData;

  /// 线路单向详情
  late SegmentList _segment;

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
  List<int> _expandIndexList = List.empty(growable: true);

  /// 站点实时信息数
  int _carInfoCount = 2;

  /// api 服务
  final ApiService apiService = ApiService();

  /// 获取线路详情
  Future<RouteStationDataEntity> _getRouteStatData() async {
    var routeStatDataEntity = await apiService.fetchRouteStationData(widget.routeId);
    // 单向信息
    _segment = routeStatDataEntity.segmentList![_index];
    // 车辆实时信息
    _segmentID = _segment.segmentID.toString();
    _routeRealTimeInfo = await apiService.fetchRouteRealTimeInfo(widget.routeId, _segmentID);
    // 定时刷新
    _refreshRouteRealTimeInfo(_segmentID);
    return routeStatDataEntity;
  }

  @override
  void initState() {
    super.initState();
    _routeStatDataFuture = _getRouteStatData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// 定时刷新车辆实时信息
  void _refreshRouteRealTimeInfo(String segmentID) {
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      print('定时刷新车辆实时信息 ${DateTime.now()}');
      _immediatelyFlush(segmentID);
      if (_expandIndexList.isNotEmpty) {
        print('定时刷新站点实时信息 ${DateTime.now()}');
        setState(() {
          _stationRealTimeInfoFuture = apiService.fetchStationRealTimeInfo(
              widget.routeId, _segment.stationList![_expandIndexList.last].stationID!);
        });
      }
    });
  }

  /// 立即刷新车辆实时信息
  _immediatelyFlush(String segmentID) async {
    var routeRealTimeInfoEntity = await apiService.fetchRouteRealTimeInfo(widget.routeId, segmentID);
    setState(() {
      _routeRealTimeInfo = routeRealTimeInfoEntity;
    });
  }

  /// 显示车辆实时信息
  Widget carRealInfo(String stationID) {
    var widget;
    // 防止请求失败时构建出现错误
    _routeRealTimeInfo.busPosList?.forEach((element) {
      // print('${element.stationID}');
      if (element.stationID == stationID) {
        // print('找到 ${element.stationID}');
        widget = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bus_alert,
              color: Colors.blueAccent,
            ),
            AutoSizeText(
              '${element.busName}',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        );
      }
    });
    return widget ?? Container();
  }

  /// 站点名称及车辆信息
  ListTile buildListTile(StationList e, int i) {
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
              e.stationName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 5,
            child: carRealInfo(e.stationID!),
          ),
        ],
      ),
    );
  }

  /// 车辆实时列表
  Widget buildListView() {
    return Column(
      children: [
        FutureBuilder<StationRealTimeInfoEntity>(
          future: _stationRealTimeInfoFuture,
          builder: (BuildContext context, AsyncSnapshot<StationRealTimeInfoEntity> snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                var height = 175 * _carInfoCount;
                return Container(
                  height: height.toDouble(),
                  child: Center(
                    child: ElevatedButton(
                      child: Text("请检查网络连接后点击重试"),
                      onPressed: reGetStationRealTimeInfo,
                    ),
                  ),
                );
              } else {
                StationRealTimeInfoEntity stationRealTimeInfo = snapshot.data!;
                var realtimeInfoList = stationRealTimeInfo.realtimeInfoList;
                _carInfoCount = realtimeInfoList!.length;
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
                      AppLocalizations.of(context)!.loading,
                    ),
                    subtitle: AutoSizeText(
                      AppLocalizations.of(context)!.loading,
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
    );
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
    var _routeDetailBuilderFunction = (BuildContext context, AsyncSnapshot<RouteStationDataEntity> snapshot) {
      // 请求已结束
      if (snapshot.connectionState == ConnectionState.done) {
        // print('FutureBuilder 数据请求完毕');
        if (snapshot.hasError) {
          // 请求失败，显示错误
          return Center(
            child: ElevatedButton(
              child: Text(AppLocalizations.of(context)!.requestDataFailure),
              onPressed: reTry,
            ),
          );
        }

        // 请求成功，显示数据
        _routeStatData = snapshot.data!;
        var length = _routeStatData.segmentList!.length;
        var stationList = _segment.stationList;

        // 展开内容,唯一一个，不然每个条目都会构建
        var isVisible = _expandIndexList.isNotEmpty;
        var carInfo;
        if (isVisible) {
          carInfo = buildListView();
        } else {
          carInfo = Container();
        }

        // 站点面板列表
        List<ExpansionPanelRadio> expansionPanelRadios = List.empty(growable: true);
        for (var i = 0; i < stationList!.length; ++i) {
          var e = stationList[i];
          var expansionPanelRadio = ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return buildListTile(e, i);
            },
            body: carInfo,
            value: e.stationID as Object,
          );
          expansionPanelRadios.add(expansionPanelRadio);
        }

        // 站点列表
        return Column(
          children: [
            // 头部信息
            RouteHeader(
              routeName: _routeStatData.routeName!,
              firstStationName: stationList.first.stationName!,
              lastStationName: stationList.last.stationName!,
              transDirection: length > 1,
              transDirectionFun: () {
                // 换向提示
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text(
                      AppLocalizations.of(context)!.reversingComplete,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                setState(() {
                  print('换向');
                  _index == 0 ? _index = 1 : _index = 0;
                  _segment = _routeStatData.segmentList![_index];
                  _segmentID = _segment.segmentID.toString();
                  _timer.cancel();
                  _immediatelyFlush(_segmentID);
                  _refreshRouteRealTimeInfo(_segmentID);
                  _expandIndexList = List.empty(growable: true);
                  _carInfoCount = 2;
                  _listKey = UniqueKey();
                });
              },
              firstAndLastBus: _segment.firstLastShiftInfo!,
              routePrice: _segment.routePrice!,
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
                        _stationRealTimeInfoFuture = apiService.fetchStationRealTimeInfo(
                            widget.routeId, _segment.stationList![_expandIndexList.last].stationID!);
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
        // 请求未结束，显示loading
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    };

    return Scaffold(
      key: _routeDetailKey,
      appBar: AppBar(
        title: AutoSizeText(
          widget.title,
        ),
      ),
      body: FutureBuilder<RouteStationDataEntity>(
        future: _routeStatDataFuture,
        builder: _routeDetailBuilderFunction,
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
      _stationRealTimeInfoFuture =
          apiService.fetchStationRealTimeInfo(widget.routeId, _segment.stationList![_expandIndexList.last].stationID!);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
