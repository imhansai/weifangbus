import 'package:json_annotation/json_annotation.dart';

part 'all_route_data_entity.g.dart';

@JsonSerializable()
class AllRouteDataEntity {
  @JsonKey(name: 'TimeStamp')
  final String? timeStamp;
  @JsonKey(name: 'RouteList')
  final List<RouteList>? routeList;
  @JsonKey(name: 'IsNewData')
  final String? isNewData;

  const AllRouteDataEntity({
    this.timeStamp,
    this.routeList,
    this.isNewData,
  });

  factory AllRouteDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AllRouteDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AllRouteDataEntityToJson(this);
}

@JsonSerializable()
class RouteList {
  @JsonKey(name: 'RouteID')
  final int? routeID;
  @JsonKey(name: 'RouteName')
  final String? routeName;
  @JsonKey(name: 'Sortinfo')
  final int? sortInfo;

  const RouteList({
    this.routeID,
    this.routeName,
    this.sortInfo,
  });

  factory RouteList.fromJson(Map<String, dynamic> json) =>
      _$RouteListFromJson(json);

  Map<String, dynamic> toJson() => _$RouteListToJson(this);
}
