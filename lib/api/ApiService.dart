import 'package:dio/dio.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/new_info_summary_entity.dart';
import 'package:weifangbus/entity/route_real_time_info_entity.dart';
import 'package:weifangbus/entity/route_station_data_entity.dart';
import 'package:weifangbus/entity/station_real_time_info_entity.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

class ApiService {
  /// 获取所有路线数据
  Future<AllRouteDataEntity> fetchAllRouteData() async {
    try {
      var uri = "/Query_AllSubRouteData/?${getSignString()}";
      Response response = await dio.get(uri);
      var data = response.data;
      // print("请求 所有路线数据 完毕!");
      // print(data);
      return AllRouteDataEntity.fromJson(data);
    } on DioException catch (e) {
      print(getErrorMsg(e, msg: "请求所有路线数据"));
      return Future.error(e);
    }
  }

  /// 获取资讯信息
  Future<List<NewInfoSummaryEntity>> fetchAllNews() async {
    try {
      var uri = '/Query_ByNewInfoSummary?UseFor=0,1,3,8,10,11,14&${getSignString()}';
      Response response = await dio.get(uri);
      List<dynamic> list = response.data;
      List<NewInfoSummaryEntity> newsList = list.map((dynamic) => NewInfoSummaryEntity.fromJson(dynamic)).toList();
      // print('请求 资讯信息 完毕');
      return newsList;
    } on DioException catch (e) {
      print(getErrorMsg(e, msg: "请求资讯信息"));
      return Future.error(e);
    }
  }

  /// 获取线路详情
  Future<RouteStationDataEntity> fetchRouteStationData(int routeId) async {
    try {
      var uri = "/Query_RouteStatData?RouteID=${encryptedString(routeId.toString())}&${getSignString()}";
      Response response = await dio.get(uri);
      List<dynamic> list = response.data;
      print('请求线路详情完毕');
      List<RouteStationDataEntity> routeStatDataEntityList =
          list.map((dynamic) => RouteStationDataEntity.fromJson(dynamic)).toList();
      return routeStatDataEntityList.first;
    } on DioException catch (e) {
      print(getErrorMsg(e, msg: "请求线路详情"));
      return Future.error(e);
    }
  }

  /// 获取车辆实时信息
  Future<RouteRealTimeInfoEntity> fetchRouteRealTimeInfo(int routeId, String segmentID) async {
    try {
      var uri =
          "/QueryDetail_ByRouteID/?RouteID=${encryptedString(routeId.toString())}&SegmentID=${encryptedString(segmentID)}&${getSignString()}";
      Response response = await dio.get(uri);
      print('请求车辆实时信息完毕');
      return RouteRealTimeInfoEntity.fromJson(response.data);
    } on DioException catch (e) {
      print(getErrorMsg(e, msg: "请求车辆实时信息"));
      return Future.error(e);
    }
  }

  /// 获取站点实时信息
  Future<StationRealTimeInfoEntity> fetchStationRealTimeInfo(int routeId, String stationId) async {
    try {
      var uri =
          "/Query_ByStationID/?RouteID=${encryptedString(routeId.toString())}&StationID=${encryptedString(stationId)}&${getSignString()}";
      Response response = await dio.get(uri);
      List<dynamic> dataList = response.data;
      List<StationRealTimeInfoEntity> routeRealTimeInfoList =
          dataList.map((e) => StationRealTimeInfoEntity.fromJson(e)).toList();
      var routeRealTimeInfo = routeRealTimeInfoList.first;
      print('请求站点实时信息完毕');
      return routeRealTimeInfo;
    } on DioException catch (e) {
      print(getErrorMsg(e, msg: "请求站点实时信息"));
      return Future.error(e);
    }
  }
}
