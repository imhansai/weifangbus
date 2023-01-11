// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_route_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllRouteDataEntity _$AllRouteDataEntityFromJson(Map<String, dynamic> json) =>
    AllRouteDataEntity(
      TimeStamp: json['TimeStamp'] as String?,
      RouteList: json['RouteList'] as List<dynamic>?,
      IsNewData: json['IsNewData'] as String?,
    );

Map<String, dynamic> _$AllRouteDataEntityToJson(AllRouteDataEntity instance) =>
    <String, dynamic>{
      'TimeStamp': instance.TimeStamp,
      'RouteList': instance.RouteList,
      'IsNewData': instance.IsNewData,
    };

Routelist _$RoutelistFromJson(Map<String, dynamic> json) => Routelist(
      RouteID: json['RouteID'] as int?,
      RouteName: json['RouteName'] as String?,
      RouteNameExt: json['RouteNameExt'] as String?,
    );

Map<String, dynamic> _$RoutelistToJson(Routelist instance) => <String, dynamic>{
      'RouteID': instance.RouteID,
      'RouteName': instance.RouteName,
      'RouteNameExt': instance.RouteNameExt,
    };
