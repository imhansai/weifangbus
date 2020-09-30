import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weifangbus/entity/line/route_real_time_info_entity.dart';
import 'package:weifangbus/entity/route_stat_data_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/view/home/line/station_detail.dart';

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
  var _routeStatData;

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

  /// 定时器
  Timer _timer;

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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
          var widgets = <Widget>[
            // 线路名称
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(
                  ScreenUtil().setWidth(20),
                ),
                child: AutoSizeText(
                  _routeStatData.routename,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(70),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // xxx -> xxx
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setHeight(20),
                  right: ScreenUtil().setWidth(20),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    // 起点站
                    Expanded(
                      // flex: 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orange[700]],
                          ),
                          borderRadius: BorderRadius.circular(3.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 4.0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            ScreenUtil().setWidth(20),
                          ),
                          child: AutoSizeText(
                            _segment.stationlist.first.stationname,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    // 方向 icon + 换向
                    Expanded(
                      // flex: 1,
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.forward,
                              color: Colors.orange,
                            ),
                          ),
                          // 换向
                          length > 1
                              ? Expanded(
                                  child: RaisedButton.icon(
                                    color: Colors.green,
                                    icon: Icon(
                                      Icons.swap_horiz,
                                      size: 15,
                                    ),
                                    label: Text(
                                      '换向',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _index == 0 ? _index = 1 : _index = 0;
                                        _segment =
                                            _routeStatData.segmentlist[_index];
                                        print('段 id ${_segment.segmentid}');
                                        _segmentID =
                                            _segment.segmentid.toString();
                                        print(_segmentID);
                                        print('重新设置定时器');
                                        _timer?.cancel();
                                        _immediatelyFlush(_segmentID);
                                        _refreshRouteRealTimeInfo(_segmentID);
                                      });
                                    },
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    // 终点站
                    Expanded(
                      // flex: 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orange[700]],
                          ),
                          borderRadius: BorderRadius.circular(3.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 4.0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            ScreenUtil().setWidth(20),
                          ),
                          child: AutoSizeText(
                            _segment.stationlist.last.stationname,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 首末班 + 票价
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  // top: ScreenUtil().setHeight(20),
                  right: ScreenUtil().setHeight(20),
                  bottom: ScreenUtil().setHeight(20),
                ),
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    // 首末班
                    Expanded(
                      child: AutoSizeText(
                        _segment.firtlastshiftinfo,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(45),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      flex: 4,
                    ),
                    // 空白填充
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    // 票价
                    Expanded(
                      child: AutoSizeText(
                        _segment.routeprice.contains('票价')
                            ? _segment.routeprice
                            : '票价: ${_segment.routeprice} 元',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(45),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      flex: 4,
                    )
                  ],
                ),
              ),
            )
          ];
          // 站点列表
          return Column(
            children: [
              // 头部信息
              Container(
                color: Colors.blueGrey,
                height: ScreenUtil().setHeight(400),
                width: double.infinity,
                child: Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction: Axis.vertical,
                  children: widgets,
                ),
              ),
              // 站点列表
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _segment.stationlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FlatButton(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                      ),
                      child: Container(
                        height: ScreenUtil().setHeight(150),
                        // 下分割线
                        decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 2,
                          ),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                _segment.stationlist[index].stationname,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(45),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              flex: 3,
                            ),
                            carRealInfo(_segment.stationlist[index].stationid),
                          ],
                        ),
                      ),
                      onPressed: () {
                        stationInfo(_segment.stationlist[index].stationid,
                            _segment.stationlist[index].stationname);
                      },
                    );
                  },
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

  @override
  bool get wantKeepAlive => true;

  /// 显示车辆实时信息
  Widget carRealInfo(String stationID) {
    var widget = Expanded(
      flex: 2,
      child: Container(),
    );
    _routeRealTimeInfo.rStaRealTInfoList.forEach((element) {
      // print('${element.stationID}');
      if (element.stationID == stationID) {
        // print('找到 ${element.stationID}');
        widget = Expanded(
          flex: 2,
          child: Container(
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      element.stopBusStaNum != 0
                          ? Icon(
                              MaterialCommunityIcons.bus_side,
                              color: Colors.green,
                              size: ScreenUtil().setWidth(70),
                            )
                          : Container(),
                      element.stopBusStaNum != 0
                          ? AutoSizeText('${element.stopBusStaNum}辆到站')
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      element.expArriveBusStaNum != 0
                          ? Icon(
                              MaterialCommunityIcons.bus_side,
                              color: Colors.red,
                              size: ScreenUtil().setWidth(70),
                            )
                          : Container(),
                      element.expArriveBusStaNum != 0
                          ? AutoSizeText('${element.expArriveBusStaNum}辆离站')
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
    return widget;
  }

  /// 重试
  void reTry() {
    setState(() {
      _routeStatDataFuture = _getRouteStatData();
    });
  }

  /// 站点点击展示内容
  void stationInfo(String stationId, String stationName) {
    print('点击了: ' + stationName);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return StationDetail(
            routeId: widget.routeId.toString(),
            stationId: stationId,
            stationName: stationName,
          );
        },
      ),
    );
  }
}
