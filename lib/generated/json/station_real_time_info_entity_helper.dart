import 'package:weifangbus/entity/line/station_real_time_info_entity.dart';

stationRealTimeInfoEntityFromJson(
    StationRealTimeInfoEntity data, Map<String, dynamic> json) {
  if (json['RouteID'] != null) {
    data.routeID = json['RouteID']?.toDouble();
  }
  if (json['RealtimeInfoList'] != null) {
    data.realtimeInfoList = new List<StationRealTimeInfoRealtimeInfoList>();
    (json['RealtimeInfoList'] as List).forEach((v) {
      data.realtimeInfoList
          .add(new StationRealTimeInfoRealtimeInfoList().fromJson(v));
    });
  }
  if (json['StationID'] != null) {
    data.stationID = json['StationID']?.toString();
  }
  if (json['StationName'] != null) {
    data.stationName = json['StationName']?.toString();
  }
  if (json['RouteName'] != null) {
    data.routeName = json['RouteName']?.toString();
  }
  if (json['EndStaInfo'] != null) {
    data.endStaInfo = json['EndStaInfo']?.toString();
  }
  if (json['FirstTime'] != null) {
    data.firstTime = json['FirstTime']?.toString();
  }
  if (json['LastTime'] != null) {
    data.lastTime = json['LastTime']?.toString();
  }
  if (json['FirtLastShiftInfo'] != null) {
    data.firtLastShiftInfo = json['FirtLastShiftInfo']?.toString();
  }
  if (json['FirtLastShiftInfo2'] != null) {
    data.firtLastShiftInfo2 = json['FirtLastShiftInfo2'];
  }
  if (json['MainSubRouteID'] != null) {
    data.mainSubRouteID = json['MainSubRouteID'];
  }
  if (json['RoutePrice'] != null) {
    data.routePrice = json['RoutePrice']?.toString();
  }
  return data;
}

Map<String, dynamic> stationRealTimeInfoEntityToJson(
    StationRealTimeInfoEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['RouteID'] = entity.routeID;
  if (entity.realtimeInfoList != null) {
    data['RealtimeInfoList'] =
        entity.realtimeInfoList.map((v) => v.toJson()).toList();
  }
  data['StationID'] = entity.stationID;
  data['StationName'] = entity.stationName;
  data['RouteName'] = entity.routeName;
  data['EndStaInfo'] = entity.endStaInfo;
  data['FirstTime'] = entity.firstTime;
  data['LastTime'] = entity.lastTime;
  data['FirtLastShiftInfo'] = entity.firtLastShiftInfo;
  data['FirtLastShiftInfo2'] = entity.firtLastShiftInfo2;
  data['MainSubRouteID'] = entity.mainSubRouteID;
  data['RoutePrice'] = entity.routePrice;
  return data;
}

stationRealTimeInfoRealtimeInfoListFromJson(
    StationRealTimeInfoRealtimeInfoList data, Map<String, dynamic> json) {
  if (json['BusID'] != null) {
    data.busID = json['BusID']?.toString();
  }
  if (json['BusName'] != null) {
    data.busName = json['BusName']?.toString();
  }
  if (json['ArriveStaName'] != null) {
    data.arriveStaName = json['ArriveStaName']?.toString();
  }
  if (json['ArriveTime'] != null) {
    data.arriveTime = json['ArriveTime']?.toString();
  }
  if (json['BusPostion'] != null) {
    data.busPostion = new StationRealTimeInfoRealtimeInfoListBusPostion()
        .fromJson(json['BusPostion']);
  }
  if (json['StationID'] != null) {
    data.stationID = json['StationID']?.toString();
  }
  if (json['SpaceNum'] != null) {
    data.spaceNum = json['SpaceNum']?.toDouble();
  }
  if (json['RunTime'] != null) {
    data.runTime = json['RunTime']?.toDouble();
  }
  if (json['Distance'] != null) {
    data.distance = json['Distance'];
  }
  if (json['ISLast'] != null) {
    data.iSLast = json['ISLast']?.toDouble();
  }
  if (json['SendTime'] != null) {
    data.sendTime = json['SendTime'];
  }
  if (json['ForeCastInfo1'] != null) {
    data.foreCastInfo1 = json['ForeCastInfo1']?.toString();
  }
  if (json['ForeCastInfo2'] != null) {
    data.foreCastInfo2 = json['ForeCastInfo2']?.toString();
  }
  if (json['Areaconglevel'] != null) {
    data.areaconglevel = json['Areaconglevel'];
  }
  if (json['Bussid'] != null) {
    data.bussid = json['Bussid'];
  }
  if (json['Temperature'] != null) {
    data.temperature = json['Temperature'];
  }
  if (json['Productid'] != null) {
    data.productid = json['Productid']?.toDouble();
  }
  if (json['SubRouteID'] != null) {
    data.subRouteID = json['SubRouteID']?.toDouble();
  }
  if (json['LeaveOrStop'] != null) {
    data.leaveOrStop = json['LeaveOrStop']?.toDouble();
  }
  if (json['islovebus'] != null) {
    data.islovebus = json['islovebus'];
  }
  return data;
}

Map<String, dynamic> stationRealTimeInfoRealtimeInfoListToJson(
    StationRealTimeInfoRealtimeInfoList entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['BusID'] = entity.busID;
  data['BusName'] = entity.busName;
  data['ArriveStaName'] = entity.arriveStaName;
  data['ArriveTime'] = entity.arriveTime;
  if (entity.busPostion != null) {
    data['BusPostion'] = entity.busPostion.toJson();
  }
  data['StationID'] = entity.stationID;
  data['SpaceNum'] = entity.spaceNum;
  data['RunTime'] = entity.runTime;
  data['Distance'] = entity.distance;
  data['ISLast'] = entity.iSLast;
  data['SendTime'] = entity.sendTime;
  data['ForeCastInfo1'] = entity.foreCastInfo1;
  data['ForeCastInfo2'] = entity.foreCastInfo2;
  data['Areaconglevel'] = entity.areaconglevel;
  data['Bussid'] = entity.bussid;
  data['Temperature'] = entity.temperature;
  data['Productid'] = entity.productid;
  data['SubRouteID'] = entity.subRouteID;
  data['LeaveOrStop'] = entity.leaveOrStop;
  data['islovebus'] = entity.islovebus;
  return data;
}

stationRealTimeInfoRealtimeInfoListBusPostionFromJson(
    StationRealTimeInfoRealtimeInfoListBusPostion data,
    Map<String, dynamic> json) {
  if (json['Longitude'] != null) {
    data.longitude = json['Longitude']?.toDouble();
  }
  if (json['Latitude'] != null) {
    data.latitude = json['Latitude']?.toDouble();
  }
  return data;
}

Map<String, dynamic> stationRealTimeInfoRealtimeInfoListBusPostionToJson(
    StationRealTimeInfoRealtimeInfoListBusPostion entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Longitude'] = entity.longitude;
  data['Latitude'] = entity.latitude;
  return data;
}
