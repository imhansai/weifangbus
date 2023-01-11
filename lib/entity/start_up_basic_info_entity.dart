import 'package:json_annotation/json_annotation.dart';

part 'start_up_basic_info_entity.g.dart';

@JsonSerializable()
class StartUpBasicInfoEntity {
  final List<dynamic>? HeadLine;
  final List<dynamic>? LoginPic;
  final List<dynamic>? SlideShow;

  const StartUpBasicInfoEntity({
    this.HeadLine,
    this.LoginPic,
    this.SlideShow,
  });

  factory StartUpBasicInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$StartUpBasicInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StartUpBasicInfoEntityToJson(this);
}

@JsonSerializable()
class Slideshow {
  final String? bannerid;
  final String? name;
  final String? title;
  final String? bannerurl;
  final String? linkurl;
  final String? bannerusefor;

  const Slideshow({
    this.bannerid,
    this.name,
    this.title,
    this.bannerurl,
    this.linkurl,
    this.bannerusefor,
  });

  factory Slideshow.fromJson(Map<String, dynamic> json) =>
      _$SlideshowFromJson(json);

  Map<String, dynamic> toJson() => _$SlideshowToJson(this);
}
