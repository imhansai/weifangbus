// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'head_line_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeadLineEntity _$HeadLineEntityFromJson(Map<String, dynamic> json) =>
    HeadLineEntity(
      ID: json['ID'] as String?,
      Title: json['Title'] as String?,
      Content: json['Content'] as String?,
      RealeaseTime: json['RealeaseTime'] as String?,
      RouteID: json['RouteID'] as String?,
      StationID: json['StationID'] as String?,
      RealeaseDateTime: json['RealeaseDateTime'] as String?,
      ContentHtml: json['ContentHtml'] as String?,
      istop1: json['istop1'],
      isscroll: json['isscroll'],
    );

Map<String, dynamic> _$HeadLineEntityToJson(HeadLineEntity instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'Title': instance.Title,
      'Content': instance.Content,
      'RealeaseTime': instance.RealeaseTime,
      'RouteID': instance.RouteID,
      'StationID': instance.StationID,
      'RealeaseDateTime': instance.RealeaseDateTime,
      'ContentHtml': instance.ContentHtml,
      'istop1': instance.istop1,
      'isscroll': instance.isscroll,
    };
