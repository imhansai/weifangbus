// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_up_basic_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartUpBasicInfoEntity _$StartUpBasicInfoEntityFromJson(
        Map<String, dynamic> json) =>
    StartUpBasicInfoEntity(
      HeadLine: json['HeadLine'] as List<dynamic>?,
      LoginPic: json['LoginPic'] as List<dynamic>?,
      SlideShow: json['SlideShow'] as List<dynamic>?,
    );

Map<String, dynamic> _$StartUpBasicInfoEntityToJson(
        StartUpBasicInfoEntity instance) =>
    <String, dynamic>{
      'HeadLine': instance.HeadLine,
      'LoginPic': instance.LoginPic,
      'SlideShow': instance.SlideShow,
    };

Slideshow _$SlideshowFromJson(Map<String, dynamic> json) => Slideshow(
      bannerid: json['bannerid'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      bannerurl: json['bannerurl'] as String?,
      linkurl: json['linkurl'] as String?,
      bannerusefor: json['bannerusefor'] as String?,
    );

Map<String, dynamic> _$SlideshowToJson(Slideshow instance) => <String, dynamic>{
      'bannerid': instance.bannerid,
      'name': instance.name,
      'title': instance.title,
      'bannerurl': instance.bannerurl,
      'linkurl': instance.linkurl,
      'bannerusefor': instance.bannerusefor,
    };
