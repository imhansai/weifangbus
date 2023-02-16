import 'package:json_annotation/json_annotation.dart';

part 'new_info_summary_entity.g.dart';

@JsonSerializable()
class NewInfoSummaryEntity {
  final String? ID;
  final String? Title;
  final String? Summary;
  final String? RealeaseTime;
  final String? UseFor;
  final List<dynamic>? ImageList;
  final dynamic RouteID;
  final dynamic StationID;
  final dynamic RouteName;
  final dynamic StationName;
  final String? StickIndex;
  final String? HomePage;
  final dynamic SubHeading;
  final dynamic TitlePicUrl;
  final String? NavigationUrl;

  const NewInfoSummaryEntity({
    this.ID,
    this.Title,
    this.Summary,
    this.RealeaseTime,
    this.UseFor,
    this.ImageList,
    this.RouteID,
    this.StationID,
    this.RouteName,
    this.StationName,
    this.StickIndex,
    this.HomePage,
    this.SubHeading,
    this.TitlePicUrl,
    this.NavigationUrl,
  });

  factory NewInfoSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$NewInfoSummaryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NewInfoSummaryEntityToJson(this);
}
