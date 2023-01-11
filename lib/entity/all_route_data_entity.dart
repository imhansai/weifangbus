import 'package:json_annotation/json_annotation.dart';

part 'all_route_data_entity.g.dart';

@JsonSerializable()
class AllRouteDataEntity {
  final String? TimeStamp;
  final List<dynamic>? RouteList;
  final String? IsNewData;

  const AllRouteDataEntity({
    this.TimeStamp,
    this.RouteList,
    this.IsNewData,
  });

  factory AllRouteDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AllRouteDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AllRouteDataEntityToJson(this);
}

@JsonSerializable()
class Routelist {
  final int? RouteID;
  final String? RouteName;
  final String? RouteNameExt;

  const Routelist({
    this.RouteID,
    this.RouteName,
    this.RouteNameExt,
  });

  factory Routelist.fromJson(Map<String, dynamic> json) =>
      _$RoutelistFromJson(json);

  Map<String, dynamic> toJson() => _$RoutelistToJson(this);
}
