import 'dart:async';

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
              children: [
                Text('当前线路名称: ${_stationRealTimeInfo.routeName}'),
                Text('当前线路方向: ${_stationRealTimeInfo.endStaInfo}'),
                Text('当前线路首班车: ${_stationRealTimeInfo.firstTime}'),
                Text('当前线路末班车: ${_stationRealTimeInfo.lastTime}'),
                Text('当前线路首末班: ${_stationRealTimeInfo.firtLastShiftInfo}'),
                Text('当前线路票价: ${_stationRealTimeInfo.routePrice}元'),
                Text('当前选择站点: ${widget.stationName}'),
                Expanded(
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
                          children: [
                            Text('车牌号: ${_realtimeInfoList[index].busName}'),
                            Text(
                                'ArriveStaName: ${_realtimeInfoList[index].arriveStaName}'),
                            Text(
                                'ArriveTime: ${_realtimeInfoList[index].arriveTime}'),
                            Text(
                                'SpaceNum: ${_realtimeInfoList[index].spaceNum}'),
                            Text(
                                'RunTime: ${_realtimeInfoList[index].runTime}'),
                            Text(
                                'ForeCastInfo1: ${_realtimeInfoList[index].foreCastInfo1}'),
                            Text(
                                'ForeCastInfo2: ${_realtimeInfoList[index].foreCastInfo2}'),
                          ],
                        ),
                      );
                    },
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
