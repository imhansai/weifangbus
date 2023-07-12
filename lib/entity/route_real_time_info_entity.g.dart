// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_real_time_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteRealTimeInfoEntity _$RouteRealTimeInfoEntityFromJson(
        Map<String, dynamic> json) =>
    RouteRealTimeInfoEntity(
      routeID: json['RouteID'] as int?,
      segmentID: json['SegmentID'] as int?,
      busPosList: (json['BusPosList'] as List<dynamic>?)
          ?.map((e) => BusPosList.fromJson(e as Map<String, dynamic>))
          .toList(),
      staLineCon: (json['StalineCon'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isEnd: json['IsEnd'],
    );

Map<String, dynamic> _$RouteRealTimeInfoEntityToJson(
        RouteRealTimeInfoEntity instance) =>
    <String, dynamic>{
      'RouteID': instance.routeID,
      'SegmentID': instance.segmentID,
      'BusPosList': instance.busPosList,
      'StalineCon': instance.staLineCon,
      'IsEnd': instance.isEnd,
    };

BusPosList _$BusPosListFromJson(Map<String, dynamic> json) => BusPosList(
      busID: json['BusID'] as String?,
      busName: json['BusName'] as String?,
      stationID: json['StationID'] as String?,
      arriveTime: json['ArriveTime'] as String?,
      arriveStaInfo: json['ArriveStaInfo'] as String?,
      nextStaInfo: json['NextStaInfo'] as String?,
      busPosition: json['BusPostion'] == null
          ? null
          : BusPosition.fromJson(json['BusPostion'] as Map<String, dynamic>),
      productId: json['Productid'] as int?,
      subRouteID: json['SubRouteID'] as int?,
      leaveOrStop: json['LeaveOrStop'] as int?,
      gpsTime: json['GPSTime'] as String?,
    );

Map<String, dynamic> _$BusPosListToJson(BusPosList instance) =>
    <String, dynamic>{
      'BusID': instance.busID,
      'BusName': instance.busName,
      'StationID': instance.stationID,
      'ArriveTime': instance.arriveTime,
      'ArriveStaInfo': instance.arriveStaInfo,
      'NextStaInfo': instance.nextStaInfo,
      'BusPostion': instance.busPosition,
      'Productid': instance.productId,
      'SubRouteID': instance.subRouteID,
      'LeaveOrStop': instance.leaveOrStop,
      'GPSTime': instance.gpsTime,
    };

BusPosition _$BusPositionFromJson(Map<String, dynamic> json) => BusPosition(
      longitude: (json['Longitude'] as num?)?.toDouble(),
      latitude: (json['Latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BusPositionToJson(BusPosition instance) =>
    <String, dynamic>{
      'Longitude': instance.longitude,
      'Latitude': instance.latitude,
    };
