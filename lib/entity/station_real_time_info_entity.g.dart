// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_real_time_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationRealTimeInfoEntity _$StationRealTimeInfoEntityFromJson(
        Map<String, dynamic> json) =>
    StationRealTimeInfoEntity(
      routeID: json['RouteID'] as int?,
      realtimeInfoList: (json['RealtimeInfoList'] as List<dynamic>?)
          ?.map((e) => RealtimeInfoList.fromJson(e as Map<String, dynamic>))
          .toList(),
      stationID: json['StationID'] as String?,
      stationName: json['StationName'] as String?,
      routeName: json['RouteName'] as String?,
      endStaInfo: json['EndStaInfo'] as String?,
      firstTime: json['FirstTime'] as String?,
      lastTime: json['LastTime'] as String?,
      firstLastShiftInfo: json['FirtLastShiftInfo'] as String?,
      firstLastShiftInfo2: json['FirtLastShiftInfo2'],
      mainSubRouteID: json['MainSubRouteID'],
      departureState: json['DepartureState'] as String?,
      serverTime: json['ServerTime'],
      sortInfo: json['Sortinfo'] as int?,
      sortInfo2: json['Sortinfo2'] as int?,
    );

Map<String, dynamic> _$StationRealTimeInfoEntityToJson(
        StationRealTimeInfoEntity instance) =>
    <String, dynamic>{
      'RouteID': instance.routeID,
      'RealtimeInfoList': instance.realtimeInfoList,
      'StationID': instance.stationID,
      'StationName': instance.stationName,
      'RouteName': instance.routeName,
      'EndStaInfo': instance.endStaInfo,
      'FirstTime': instance.firstTime,
      'LastTime': instance.lastTime,
      'FirtLastShiftInfo': instance.firstLastShiftInfo,
      'FirtLastShiftInfo2': instance.firstLastShiftInfo2,
      'MainSubRouteID': instance.mainSubRouteID,
      'DepartureState': instance.departureState,
      'ServerTime': instance.serverTime,
      'Sortinfo': instance.sortInfo,
      'Sortinfo2': instance.sortInfo2,
    };

RealtimeInfoList _$RealtimeInfoListFromJson(Map<String, dynamic> json) =>
    RealtimeInfoList(
      busID: json['BusID'] as String?,
      busName: json['BusName'] as String?,
      arriveStaName: json['ArriveStaName'] as String?,
      arriveTime: json['ArriveTime'] as String?,
      busPosition: json['BusPostion'] == null
          ? null
          : BusPosition.fromJson(json['BusPostion'] as Map<String, dynamic>),
      stationID: json['StationID'] as String?,
      spaceNum: json['SpaceNum'] as int?,
      runTime: json['RunTime'] as int?,
      distance: json['Distance'] as String?,
      iSLast: json['ISLast'] as int?,
      foreCastInfo1: json['ForeCastInfo1'] as String?,
      foreCastInfo2: json['ForeCastInfo2'] as String?,
      areaCongLevel: json['Areaconglevel'] as String?,
      temperature: json['Temperature'] as String?,
      productId: json['Productid'] as int?,
      subRouteID: json['SubRouteID'] as int?,
      leaveOrStop: json['LeaveOrStop'] as int?,
      departureState: json['DepartureState'] as String?,
      sortTime: (json['SortTime'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RealtimeInfoListToJson(RealtimeInfoList instance) =>
    <String, dynamic>{
      'BusID': instance.busID,
      'BusName': instance.busName,
      'ArriveStaName': instance.arriveStaName,
      'ArriveTime': instance.arriveTime,
      'BusPostion': instance.busPosition,
      'StationID': instance.stationID,
      'SpaceNum': instance.spaceNum,
      'RunTime': instance.runTime,
      'Distance': instance.distance,
      'ISLast': instance.iSLast,
      'ForeCastInfo1': instance.foreCastInfo1,
      'ForeCastInfo2': instance.foreCastInfo2,
      'Areaconglevel': instance.areaCongLevel,
      'Temperature': instance.temperature,
      'Productid': instance.productId,
      'SubRouteID': instance.subRouteID,
      'LeaveOrStop': instance.leaveOrStop,
      'DepartureState': instance.departureState,
      'SortTime': instance.sortTime,
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
