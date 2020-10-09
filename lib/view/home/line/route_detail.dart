import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weifangbus/entity/line/route_real_time_info_entity.dart';
import 'package:weifangbus/entity/line/station_real_time_info_entity.dart';
import 'package:weifangbus/entity/route_stat_data_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/widget/route_header.dart';

/// 线路详情
class RouteDetail extends StatefulWidget {
  final String title;
  final int routeId;

  const RouteDetail({Key key, this.title, this.routeId}) : super(key: key);

  @override
  _RouteDetailState createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail>
    with AutomaticKeepAliveClientMixin {
  /// 线路详情
  RouteStatDataEntity _routeStatData;

  /// 线路单向详情
  RouteStatDataSegmentList _segment;

  /// 换向
  var _index = 0;

  /// 避免重绘
  var _routeStatDataFuture;

  /// 车辆实时信息
  RouteRealTimeInfoEntity _routeRealTimeInfo;

  /// 获取车辆实时信息必需参数
  var _segmentID;

  /// 车辆实时信息定时器
  Timer _timer;

  /// 站点实时信息
  List<StationRealTimeInfoRealtimeInfoList> _realtimeInfoList = List();

  /// 站点实时信息定时器
  Timer _carInfoTimer;

  var _expandStationId;

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
    } catch (e) {
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
    _carInfoTimer?.cancel();
    super.dispose();
  }

  /// 定时刷新车辆实时信息
  void _refreshRouteRealTimeInfo(String segmentID) {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      print('定时刷新车辆实时信息 ${DateTime.now()}');
      _immediatelyFlush(segmentID);
    });
  }

  /// 立即刷新车辆实时信息
  _immediatelyFlush(String segmentID) async {
    var routeRealTimeInfoEntity = await _getRouteRealTimeInfo(segmentID);
    setState(() {
      _routeRealTimeInfo = routeRealTimeInfoEntity;
    });
  }

  /// 车辆实时信息
  Future<RouteRealTimeInfoEntity> _getRouteRealTimeInfo(
      String segmentID) async {
    try {
      Response response;
      var uri = "/BusService/Query_ByRouteID/?RouteID=" +
          widget.routeId.toString() +
          "&SegmentID=" +
          segmentID +
          "&" +
          getSignString();
      // print(uri);
      response = await dio.get(uri);
      // print(response.data);
      var routeRealTimeInfo =
          JsonConvert.fromJsonAsT<RouteRealTimeInfoEntity>(response.data);
      print('请求车辆实时信息完毕');
      return routeRealTimeInfo;
    } catch (e) {
      print(getErrorMsg(e, msg: "请求车辆实时信息"));
      return Future.error(e);
    }
  }

  /// 显示车辆实时信息
  Widget carRealInfo(String stationID) {
    var widget;
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
                            // size: ScreenUtil().setWidth(70),
                          ),
                          AutoSizeText(
                            '${element.stopBusStaNum}辆到站',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
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
                            // size: ScreenUtil().setWidth(70),
                          ),
                          AutoSizeText(
                            '${element.expArriveBusStaNum}辆离站',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
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
    return widget ?? Container();
  }

  /// 定时刷新站点实时信息
  void _refreshCarInfo(String stationId) {
    _carInfoTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      print('定时刷新站点实时信息 ${DateTime.now()}');
      var stationRealTimeInfo = await _getStationRealTimeInfoEntity(stationId);
      setState(() {
        _realtimeInfoList = stationRealTimeInfo.realtimeInfoList;
      });
    });
  }

  /// 刷新站点实时信息
  Future<void> _refreshStationRealTimeInfo(String stationId) async {
    // print('routeId: ${widget.routeId} stationId: $stationId');
    var stationRealTimeInfo = await _getStationRealTimeInfoEntity(stationId);
    setState(() {
      _realtimeInfoList = stationRealTimeInfo.realtimeInfoList;
    });
    // todo 测试直接覆盖赋值
    _carInfoTimer?.cancel();
    _refreshCarInfo(stationId);
  }

  Future<StationRealTimeInfoEntity> _getStationRealTimeInfoEntity(
      String stationId) async {
    try {
      Response response;
      var uri = "/BusService/Query_ByStationID/?RouteID=" +
          widget.routeId.toString() +
          "&StationID=" +
          stationId +
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
      // _realtimeInfoList = routeRealTimeInfo.realtimeInfoList;
      return routeRealTimeInfo;
    } catch (e) {
      print(getErrorMsg(e, msg: "请求站点实时信息"));
      return Future.error(e);
    }
  }

  /// 车辆实时列表
  ListView buildListView() {
    print('车辆信息列表开始构建');
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _realtimeInfoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: AutoSizeText(
            '${_realtimeInfoList[index].busName} ${_realtimeInfoList[index].foreCastInfo2}到达',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(70),
            ),
          ),
          subtitle: AutoSizeText(
            '${_realtimeInfoList[index].foreCastInfo1} ${_realtimeInfoList[index].arriveStaName}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(45),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('界面开始构建');
    super.build(context);
    var _routeDetailBuilderFunction =
        (BuildContext context, AsyncSnapshot<RouteStatDataEntity> snapshot) {
      // 请求已结束
      if (snapshot.connectionState == ConnectionState.done) {
        // print('FutureBuilder 数据请求完毕');
        if (snapshot.hasError) {
          // 请求失败，显示错误
          return Center(
            child: RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("请检查网络连接后点击重试"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: reTry,
            ),
          );
        } else {
          // 请求成功，显示数据
          _routeStatData = snapshot.data;
          var length = _routeStatData.segmentlist.length;
          var stationList = _segment.stationlist;

          var carInfo = buildListView();

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
                  setState(() {
                    print('换向');
                    _index == 0 ? _index = 1 : _index = 0;
                    _segment = _routeStatData.segmentlist[_index];
                    _segmentID = _segment.segmentid.toString();
                    _timer?.cancel();
                    _immediatelyFlush(_segmentID);
                    _refreshRouteRealTimeInfo(_segmentID);
                    _expandStationId = null;
                    _carInfoTimer?.cancel();
                  });
                },
                firstAndLastBus: _segment.firtlastshiftinfo,
                routePrice: _segment.routeprice,
              ),
              // 站点列表
              Expanded(
                child: SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    expansionCallback: (int index, bool isExpanded) {
                      print('点击 $index 状态 $isExpanded');
                      // 收缩时清空展开索引，不需要构建车辆实时信息
                      if (isExpanded) {
                        _expandStationId = null;
                        _carInfoTimer?.cancel();
                      }
                    },
                    children: stationList
                        .map((e) => ExpansionPanelRadio(
                              canTapOnHeader: true,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                if (isExpanded &&
                                    e.stationid != _expandStationId) {
                                  print(
                                      '${e.stationname} isExpanded $isExpanded');
                                  _expandStationId = e.stationid;
                                  // 只有展开时才发起请求
                                  _refreshStationRealTimeInfo(e.stationid);
                                }
                                return ListTile(
                                  title: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: AutoSizeText(
                                          e.stationname,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: carRealInfo(e.stationid),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              body: _expandStationId == e.stationid
                                  ? carInfo
                                  : Container(),
                              value: e.stationid,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        }
      } else {
        // 请求未结束，显示loading
        return Center(
          // child: CircularProgressIndicator(),
          child: SpinKitWave(
            color: Colors.blue,
            type: SpinKitWaveType.center,
          ),
        );
      }
    };

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          widget.title,
          style: TextStyle(fontSize: ScreenUtil().setSp(45)),
          maxLines: 2,
        ),
      ),
      body: FutureBuilder<RouteStatDataEntity>(
        future: _routeStatDataFuture,
        builder: _routeDetailBuilderFunction,
      ),
    );
  }

  /// 重试
  void reTry() {
    setState(() {
      _routeStatDataFuture = _getRouteStatData();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
