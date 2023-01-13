// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_stat_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteStatDataEntity _$RouteStatDataEntityFromJson(Map<String, dynamic> json) =>
    RouteStatDataEntity(
      IsNewData: json['IsNewData'] as String?,
      RouteID: json['RouteID'] as int?,
      RouteName: json['RouteName'] as String?,
      RouteType: json['RouteType'] as String?,
      SegmentList: (json['SegmentList'] as List<dynamic>?)
          ?.map((e) => Segmentlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      TimeStamp: json['TimeStamp'] as String?,
      RouteMemo: json['RouteMemo'],
      IsBRT: json['IsBRT'] as String?,
      BrotherRoute: json['BrotherRoute'],
      Ismainsub: json['Ismainsub'],
    );

Map<String, dynamic> _$RouteStatDataEntityToJson(
        RouteStatDataEntity instance) =>
    <String, dynamic>{
      'IsNewData': instance.IsNewData,
      'RouteID': instance.RouteID,
      'RouteName': instance.RouteName,
      'RouteType': instance.RouteType,
      'SegmentList': instance.SegmentList,
      'TimeStamp': instance.TimeStamp,
      'RouteMemo': instance.RouteMemo,
      'IsBRT': instance.IsBRT,
      'BrotherRoute': instance.BrotherRoute,
      'Ismainsub': instance.Ismainsub,
    };

Segmentlist _$SegmentlistFromJson(Map<String, dynamic> json) => Segmentlist(
      SegmentID: json['SegmentID'] as int?,
      SegmentName: json['SegmentName'] as String?,
      FirstTime: json['FirstTime'] as String?,
      LastTime: json['LastTime'] as String?,
      RoutePrice: json['RoutePrice'] as String?,
      NormalTimeSpan: json['NormalTimeSpan'] as int?,
      PeakTimeSpan: json['PeakTimeSpan'] as int?,
      StationList: (json['StationList'] as List<dynamic>?)
          ?.map((e) => Stationlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      FirtLastShiftInfo: json['FirtLastShiftInfo'] as String?,
      Memos: json['Memos'] as String?,
      RunDirection: json['RunDirection'] as String?,
      Baidumapid: json['Baidumapid'] as String?,
      Amapid: json['Amapid'] as String?,
      DrawType: json['DrawType'] as String?,
    );

Map<String, dynamic> _$SegmentlistToJson(Segmentlist instance) =>
    <String, dynamic>{
      'SegmentID': instance.SegmentID,
      'SegmentName': instance.SegmentName,
      'FirstTime': instance.FirstTime,
      'LastTime': instance.LastTime,
      'RoutePrice': instance.RoutePrice,
      'NormalTimeSpan': instance.NormalTimeSpan,
      'PeakTimeSpan': instance.PeakTimeSpan,
      'StationList': instance.StationList,
      'FirtLastShiftInfo': instance.FirtLastShiftInfo,
      'Memos': instance.Memos,
      'RunDirection': instance.RunDirection,
      'Baidumapid': instance.Baidumapid,
      'Amapid': instance.Amapid,
      'DrawType': instance.DrawType,
    };

Stationlist _$StationlistFromJson(Map<String, dynamic> json) => Stationlist(
      StationID: json['StationID'] as String?,
      StationName: json['StationName'] as String?,
      StationNO: json['StationNO'] as String?,
      StationPostion: json['StationPostion'] == null
          ? null
          : Stationpostion.fromJson(
              json['StationPostion'] as Map<String, dynamic>),
      Stationmemo: json['Stationmemo'] as String?,
      DualSerial: json['DualSerial'] as int?,
      StationSort: json['StationSort'] as int?,
    );

Map<String, dynamic> _$StationlistToJson(Stationlist instance) =>
    <String, dynamic>{
      'StationID': instance.StationID,
      'StationName': instance.StationName,
      'StationNO': instance.StationNO,
      'StationPostion': instance.StationPostion,
      'Stationmemo': instance.Stationmemo,
      'DualSerial': instance.DualSerial,
      'StationSort': instance.StationSort,
    };

Stationpostion _$StationpostionFromJson(Map<String, dynamic> json) =>
    Stationpostion(
      Longitude: (json['Longitude'] as num?)?.toDouble(),
      Latitude: (json['Latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationpostionToJson(Stationpostion instance) =>
    <String, dynamic>{
      'Longitude': instance.Longitude,
      'Latitude': instance.Latitude,
    };
