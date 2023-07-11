// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_info_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewInfoSummaryEntity _$NewInfoSummaryEntityFromJson(
        Map<String, dynamic> json) =>
    NewInfoSummaryEntity(
      id: json['ID'] as String?,
      title: json['Title'] as String?,
      summary: json['Summary'] as String?,
      releaseTime: json['RealeaseTime'] as String?,
      useFor: json['UseFor'] as String?,
      imageList: json['ImageList'] as List<dynamic>?,
      routeID: json['RouteID'],
      stationID: json['StationID'],
      routeName: json['RouteName'],
      stationName: json['StationName'],
      stickIndex: json['StickIndex'] as String?,
      homePage: json['HomePage'] as String?,
      subHeading: json['SubHeading'],
      titlePicUrl: json['TitlePicUrl'],
      navigationUrl: json['NavigationUrl'] as String?,
    );

Map<String, dynamic> _$NewInfoSummaryEntityToJson(
        NewInfoSummaryEntity instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Title': instance.title,
      'Summary': instance.summary,
      'RealeaseTime': instance.releaseTime,
      'UseFor': instance.useFor,
      'ImageList': instance.imageList,
      'RouteID': instance.routeID,
      'StationID': instance.stationID,
      'RouteName': instance.routeName,
      'StationName': instance.stationName,
      'StickIndex': instance.stickIndex,
      'HomePage': instance.homePage,
      'SubHeading': instance.subHeading,
      'TitlePicUrl': instance.titlePicUrl,
      'NavigationUrl': instance.navigationUrl,
    };
