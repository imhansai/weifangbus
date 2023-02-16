// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_info_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewInfoSummaryEntity _$NewInfoSummaryEntityFromJson(
        Map<String, dynamic> json) =>
    NewInfoSummaryEntity(
      ID: json['ID'] as String?,
      Title: json['Title'] as String?,
      Summary: json['Summary'] as String?,
      RealeaseTime: json['RealeaseTime'] as String?,
      UseFor: json['UseFor'] as String?,
      ImageList: json['ImageList'] as List<dynamic>?,
      RouteID: json['RouteID'],
      StationID: json['StationID'],
      RouteName: json['RouteName'],
      StationName: json['StationName'],
      StickIndex: json['StickIndex'] as String?,
      HomePage: json['HomePage'] as String?,
      SubHeading: json['SubHeading'],
      TitlePicUrl: json['TitlePicUrl'],
      NavigationUrl: json['NavigationUrl'] as String?,
    );

Map<String, dynamic> _$NewInfoSummaryEntityToJson(
        NewInfoSummaryEntity instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'Title': instance.Title,
      'Summary': instance.Summary,
      'RealeaseTime': instance.RealeaseTime,
      'UseFor': instance.UseFor,
      'ImageList': instance.ImageList,
      'RouteID': instance.RouteID,
      'StationID': instance.StationID,
      'RouteName': instance.RouteName,
      'StationName': instance.StationName,
      'StickIndex': instance.StickIndex,
      'HomePage': instance.HomePage,
      'SubHeading': instance.SubHeading,
      'TitlePicUrl': instance.TitlePicUrl,
      'NavigationUrl': instance.NavigationUrl,
    };
