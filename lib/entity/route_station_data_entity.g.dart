// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_station_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteStationDataEntity _$RouteStationDataEntityFromJson(
        Map<String, dynamic> json) =>
    RouteStationDataEntity(
      isNewData: json['IsNewData'] as String?,
      routeID: json['RouteID'] as int?,
      routeName: json['RouteName'] as String?,
      routeType: json['RouteType'] as String?,
      segmentList: (json['SegmentList'] as List<dynamic>?)
          ?.map((e) => SegmentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeStamp: json['TimeStamp'] as String?,
      routeMemo: json['RouteMemo'],
      isBRT: json['IsBRT'] as String?,
      brotherRoute: json['BrotherRoute'],
      isMainSub: json['Ismainsub'] as String?,
    );

Map<String, dynamic> _$RouteStationDataEntityToJson(
        RouteStationDataEntity instance) =>
    <String, dynamic>{
      'IsNewData': instance.isNewData,
      'RouteID': instance.routeID,
      'RouteName': instance.routeName,
      'RouteType': instance.routeType,
      'SegmentList': instance.segmentList,
      'TimeStamp': instance.timeStamp,
      'RouteMemo': instance.routeMemo,
      'IsBRT': instance.isBRT,
      'BrotherRoute': instance.brotherRoute,
      'Ismainsub': instance.isMainSub,
    };

SegmentList _$SegmentListFromJson(Map<String, dynamic> json) => SegmentList(
      segmentID: json['SegmentID'] as int?,
      segmentName: json['SegmentName'] as String?,
      firstTime: json['FirstTime'] as String?,
      lastTime: json['LastTime'] as String?,
      routePrice: json['RoutePrice'] as String?,
      normalTimeSpan: json['NormalTimeSpan'] as int?,
      peakTimeSpan: (json['PeakTimeSpan'] as num?)?.toDouble(),
      stationList: (json['StationList'] as List<dynamic>?)
          ?.map((e) => StationList.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstLastShiftInfo: json['FirtLastShiftInfo'] as String?,
      runDirection: json['RunDirection'] as String?,
      baiduMapId: json['Baidumapid'] as String?,
      drawType: json['DrawType'] as String?,
    );

Map<String, dynamic> _$SegmentListToJson(SegmentList instance) =>
    <String, dynamic>{
      'SegmentID': instance.segmentID,
      'SegmentName': instance.segmentName,
      'FirstTime': instance.firstTime,
      'LastTime': instance.lastTime,
      'RoutePrice': instance.routePrice,
      'NormalTimeSpan': instance.normalTimeSpan,
      'PeakTimeSpan': instance.peakTimeSpan,
      'StationList': instance.stationList,
      'FirtLastShiftInfo': instance.firstLastShiftInfo,
      'RunDirection': instance.runDirection,
      'Baidumapid': instance.baiduMapId,
      'DrawType': instance.drawType,
    };

StationList _$StationListFromJson(Map<String, dynamic> json) => StationList(
      stationID: json['StationID'] as String?,
      stationName: json['StationName'] as String?,
      stationNO: json['StationNO'] as String?,
      stationPosition: json['StationPostion'] == null
          ? null
          : StationPosition.fromJson(
              json['StationPostion'] as Map<String, dynamic>),
      dualSerial: json['DualSerial'] as int?,
      sngSerialId: json['Sngserialid'] as int?,
      stationSort: json['StationSort'] as int?,
      stationSectionList: (json['StationSectionList'] as List<dynamic>?)
          ?.map((e) => StationSectionList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StationListToJson(StationList instance) =>
    <String, dynamic>{
      'StationID': instance.stationID,
      'StationName': instance.stationName,
      'StationNO': instance.stationNO,
      'StationPostion': instance.stationPosition,
      'DualSerial': instance.dualSerial,
      'Sngserialid': instance.sngSerialId,
      'StationSort': instance.stationSort,
      'StationSectionList': instance.stationSectionList,
    };

StationPosition _$StationPositionFromJson(Map<String, dynamic> json) =>
    StationPosition(
      longitude: (json['Longitude'] as num?)?.toDouble(),
      latitude: (json['Latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationPositionToJson(StationPosition instance) =>
    <String, dynamic>{
      'Longitude': instance.longitude,
      'Latitude': instance.latitude,
    };

StationSectionList _$StationSectionListFromJson(Map<String, dynamic> json) =>
    StationSectionList(
      stationID: json['StationID'] as String?,
      sectionPosition: json['SectionPostion'] == null
          ? null
          : SectionPosition.fromJson(
              json['SectionPostion'] as Map<String, dynamic>),
      degreeOfCongestion: json['DegreeOfCongestion'] as String?,
      speed: json['Speed'] as String?,
    );

Map<String, dynamic> _$StationSectionListToJson(StationSectionList instance) =>
    <String, dynamic>{
      'StationID': instance.stationID,
      'SectionPostion': instance.sectionPosition,
      'DegreeOfCongestion': instance.degreeOfCongestion,
      'Speed': instance.speed,
    };

SectionPosition _$SectionPositionFromJson(Map<String, dynamic> json) =>
    SectionPosition(
      longitude: (json['Longitude'] as num?)?.toDouble(),
      latitude: (json['Latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SectionPositionToJson(SectionPosition instance) =>
    <String, dynamic>{
      'Longitude': instance.longitude,
      'Latitude': instance.latitude,
    };
