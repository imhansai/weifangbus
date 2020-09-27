import 'package:weifangbus/entity/line/route_real_time_info_entity.dart';

routeRealTimeInfoEntityFromJson(
    RouteRealTimeInfoEntity data, Map<String, dynamic> json) {
  if (json['RouteID'] != null) {
    data.routeID = json['RouteID']?.toInt();
  }
  if (json['RunBusNum'] != null) {
    data.runBusNum = json['RunBusNum']?.toInt();
  }
  if (json['RStaRealTInfoList'] != null) {
    data.rStaRealTInfoList = new List<RouteRealTimeInfoRStaRealTInfoList>();
    (json['RStaRealTInfoList'] as List).forEach((v) {
      data.rStaRealTInfoList
          .add(new RouteRealTimeInfoRStaRealTInfoList().fromJson(v));
    });
  }
  if (json['IsEnd'] != null) {
    data.isEnd = json['IsEnd'];
  }
  return data;
}

Map<String, dynamic> routeRealTimeInfoEntityToJson(
    RouteRealTimeInfoEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['RouteID'] = entity.routeID;
  data['RunBusNum'] = entity.runBusNum;
  if (entity.rStaRealTInfoList != null) {
    data['RStaRealTInfoList'] =
        entity.rStaRealTInfoList.map((v) => v.toJson()).toList();
  }
  data['IsEnd'] = entity.isEnd;
  return data;
}

routeRealTimeInfoRStaRealTInfoListFromJson(
    RouteRealTimeInfoRStaRealTInfoList data, Map<String, dynamic> json) {
  if (json['StationID'] != null) {
    data.stationID = json['StationID']?.toString();
  }
  if (json['RStanum'] != null) {
    data.rStanum = json['RStanum']?.toInt();
  }
  if (json['ExpArriveBusStaNum'] != null) {
    data.expArriveBusStaNum = json['ExpArriveBusStaNum']?.toInt();
  }
  if (json['StopBusStaNum'] != null) {
    data.stopBusStaNum = json['StopBusStaNum']?.toInt();
  }
  if (json['BusType'] != null) {
    data.busType = json['BusType']?.toInt();
  }
  if (json['MediaRouteName'] != null) {
    data.mediaRouteName = json['MediaRouteName'];
  }
  if (json['islovebus'] != null) {
    data.islovebus = json['islovebus'];
  }
  return data;
}

Map<String, dynamic> routeRealTimeInfoRStaRealTInfoListToJson(
    RouteRealTimeInfoRStaRealTInfoList entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['StationID'] = entity.stationID;
  data['RStanum'] = entity.rStanum;
  data['ExpArriveBusStaNum'] = entity.expArriveBusStaNum;
  data['StopBusStaNum'] = entity.stopBusStaNum;
  data['BusType'] = entity.busType;
  data['MediaRouteName'] = entity.mediaRouteName;
  data['islovebus'] = entity.islovebus;
  return data;
}
