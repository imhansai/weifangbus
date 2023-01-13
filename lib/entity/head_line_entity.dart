import 'package:json_annotation/json_annotation.dart';

part 'head_line_entity.g.dart';

@JsonSerializable()
class HeadLineEntity {
  final String? ID;
  final String? Title;
  final String? Content;
  final String? RealeaseTime;
  final String? RouteID;
  final String? StationID;
  final String? RealeaseDateTime;
  final String? ContentHtml;
  final dynamic istop1;
  final dynamic isscroll;

  const HeadLineEntity({
    this.ID,
    this.Title,
    this.Content,
    this.RealeaseTime,
    this.RouteID,
    this.StationID,
    this.RealeaseDateTime,
    this.ContentHtml,
    this.istop1,
    this.isscroll,
  });

  factory HeadLineEntity.fromJson(Map<String, dynamic> json) =>
      _$HeadLineEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HeadLineEntityToJson(this);
}
