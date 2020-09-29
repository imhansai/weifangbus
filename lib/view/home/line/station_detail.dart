import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weifangbus/entity/line/station_real_time_info_entity.dart';
import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

/// 站点详情
class StationDetail extends StatefulWidget {
  final String routeId;
  final String stationId;
  final String stationName;

  const StationDetail({Key key, this.routeId, this.stationId, this.stationName})
      : super(key: key);

  @override
  _StationDetailState createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail>
    with AutomaticKeepAliveClientMixin {
  /// 避免重绘
  Future<StationRealTimeInfoEntity> _stationRealTimeInfoFuture;

  /// 站点详情
  StationRealTimeInfoEntity _stationRealTimeInfo;

  /// 车辆信息
  List<StationRealTimeInfoRealtimeInfoList> _realtimeInfoList;

  /// 定时器
  Timer _timer;

  /// 定时刷新站点实时信息
  void _refreshStationRealTimeInfo() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      print('定时刷新站点实时信息 ${DateTime.now()}');
      var stationRealTimeInfo = await _getStationRealTimeInfoEntity();
      setState(() {
        _realtimeInfoList = stationRealTimeInfo.realtimeInfoList;
      });
    });
  }

  Future<StationRealTimeInfoEntity> _getStationRealTimeInfoEntity() async {
    try {
      Response response;
      var uri = "/BusService/Query_ByStationID/?RouteID=" +
          widget.routeId +
          "&StationID=" +
          widget.stationId +
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
      _realtimeInfoList = routeRealTimeInfo.realtimeInfoList;
      return routeRealTimeInfo;
    } catch (e) {
      print(getErrorMsg(e, msg: "请求站点实时信息"));
      return Future.error(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _stationRealTimeInfoFuture = _getStationRealTimeInfoEntity();
    // 定时刷新
    _refreshStationRealTimeInfo();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var _stationDetailBuilder = (BuildContext context,
        AsyncSnapshot<StationRealTimeInfoEntity> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
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
              onPressed: () {},
            ),
          );
        } else {
          _stationRealTimeInfo = snapshot.data;
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    ScreenUtil().setWidth(20),
                  ),
                  child: Container(
                    height: ScreenUtil().setHeight(430),
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(20),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyan[700], Colors.cyan],
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0),
                      ],
                    ),
                    width: double.infinity,
                    // color: Colors.cyan,
                    child: ListView(
                      children: [
                        AutoSizeText(
                          '${widget.stationName}',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(70),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(15),
                          ),
                          child: AutoSizeText(
                            '当前线路名称: ${_stationRealTimeInfo?.routeName}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(15),
                          ),
                          child: AutoSizeText(
                            '方向: ${_stationRealTimeInfo?.endStaInfo}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(15),
                          ),
                          child: AutoSizeText(
                            '${_stationRealTimeInfo?.firtLastShiftInfo}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(15),
                          ),
                          child: AutoSizeText(
                            '票价: ${_stationRealTimeInfo?.routePrice}元',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    ScreenUtil().setHeight(20),
                  ),
                  child: AutoSizeText(
                    '车辆信息:',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(50),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      right: ScreenUtil().setWidth(30),
                    ),
                    child: ListView.builder(
                      itemCount: _realtimeInfoList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: ScreenUtil().setHeight(5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setWidth(15),
                                ),
                                child: AutoSizeText(
                                  '车牌号: ${_realtimeInfoList[index].busName}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(45),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setWidth(10),
                                ),
                                child: AutoSizeText(
                                  '车辆状态: ${_realtimeInfoList[index].foreCastInfo1} ${_realtimeInfoList[index].arriveStaName}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(43),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setWidth(10),
                                ),
                                child: AutoSizeText(
                                  '记录时间: ${_realtimeInfoList[index].arriveTime}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(43),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setWidth(10),
                                ),
                                child: AutoSizeText(
                                  '预测${_realtimeInfoList[index].foreCastInfo2}到达',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(43),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
      } else {
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
        title: Text(widget.stationName),
      ),
      body: FutureBuilder<StationRealTimeInfoEntity>(
        future: _stationRealTimeInfoFuture,
        builder: _stationDetailBuilder,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
