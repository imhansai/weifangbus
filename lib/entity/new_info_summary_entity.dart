import 'package:json_annotation/json_annotation.dart';

part 'new_info_summary_entity.g.dart';

@JsonSerializable()
class NewInfoSummaryEntity {
  @JsonKey(name: 'ID')
  final String? id;
  @JsonKey(name: 'Title')
  final String? title;
  @JsonKey(name: 'Summary')
  final String? summary;
  @JsonKey(name: 'RealeaseTime')
  final String? releaseTime;
  @JsonKey(name: 'UseFor')
  final String? useFor;
  @JsonKey(name: 'ImageList')
  final List<dynamic>? imageList;
  @JsonKey(name: 'RouteID')
  final dynamic routeID;
  @JsonKey(name: 'StationID')
  final dynamic stationID;
  @JsonKey(name: 'RouteName')
  final dynamic routeName;
  @JsonKey(name: 'StationName')
  final dynamic stationName;
  @JsonKey(name: 'StickIndex')
  final String? stickIndex;
  @JsonKey(name: 'HomePage')
  final String? homePage;
  @JsonKey(name: 'SubHeading')
  final dynamic subHeading;
  @JsonKey(name: 'TitlePicUrl')
  final dynamic titlePicUrl;
  @JsonKey(name: 'NavigationUrl')
  final String? navigationUrl;

  const NewInfoSummaryEntity({
    this.id,
    this.title,
    this.summary,
    this.releaseTime,
    this.useFor,
    this.imageList,
    this.routeID,
    this.stationID,
    this.routeName,
    this.stationName,
    this.stickIndex,
    this.homePage,
    this.subHeading,
    this.titlePicUrl,
    this.navigationUrl,
  });

  factory NewInfoSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$NewInfoSummaryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NewInfoSummaryEntityToJson(this);
}
