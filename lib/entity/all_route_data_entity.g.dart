// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_route_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllRouteDataEntity _$AllRouteDataEntityFromJson(Map<String, dynamic> json) =>
    AllRouteDataEntity(
      timeStamp: json['TimeStamp'] as String?,
      routeList: (json['RouteList'] as List<dynamic>?)
          ?.map((e) => RouteList.fromJson(e as Map<String, dynamic>))
          .toList(),
      isNewData: json['IsNewData'] as String?,
    );

Map<String, dynamic> _$AllRouteDataEntityToJson(AllRouteDataEntity instance) =>
    <String, dynamic>{
      'TimeStamp': instance.timeStamp,
      'RouteList': instance.routeList,
      'IsNewData': instance.isNewData,
    };

RouteList _$RouteListFromJson(Map<String, dynamic> json) => RouteList(
      routeID: json['RouteID'] as int?,
      routeName: json['RouteName'] as String?,
      sortInfo: json['Sortinfo'] as int?,
    );

Map<String, dynamic> _$RouteListToJson(RouteList instance) => <String, dynamic>{
      'RouteID': instance.routeID,
      'RouteName': instance.routeName,
      'Sortinfo': instance.sortInfo,
    };
