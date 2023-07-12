import 'package:json_annotation/json_annotation.dart';

part 'route_real_time_info_entity.g.dart';

@JsonSerializable()
class RouteRealTimeInfoEntity {
  @JsonKey(name: 'RouteID')
  final int? routeID;
  @JsonKey(name: 'SegmentID')
  final int? segmentID;
  @JsonKey(name: 'BusPosList')
  final List<BusPosList>? busPosList;
  @JsonKey(name: 'StalineCon')
  final List<String>? staLineCon;
  @JsonKey(name: 'IsEnd')
  final dynamic isEnd;

  const RouteRealTimeInfoEntity({
    this.routeID,
    this.segmentID,
    this.busPosList,
    this.staLineCon,
    this.isEnd,
  });

  factory RouteRealTimeInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$RouteRealTimeInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RouteRealTimeInfoEntityToJson(this);
}

@JsonSerializable()
class BusPosList {
  @JsonKey(name: 'BusID')
  final String? busID;
  @JsonKey(name: 'BusName')
  final String? busName;
  @JsonKey(name: 'StationID')
  final String? stationID;
  @JsonKey(name: 'ArriveTime')
  final String? arriveTime;
  @JsonKey(name: 'ArriveStaInfo')
  final String? arriveStaInfo;
  @JsonKey(name: 'NextStaInfo')
  final String? nextStaInfo;
  @JsonKey(name: 'BusPostion')
  final BusPosition? busPosition;
  @JsonKey(name: 'Productid')
  final int? productId;
  @JsonKey(name: 'SubRouteID')
  final int? subRouteID;
  @JsonKey(name: 'LeaveOrStop')
  final int? leaveOrStop;
  @JsonKey(name: 'GPSTime')
  final String? gpsTime;

  const BusPosList({
    this.busID,
    this.busName,
    this.stationID,
    this.arriveTime,
    this.arriveStaInfo,
    this.nextStaInfo,
    this.busPosition,
    this.productId,
    this.subRouteID,
    this.leaveOrStop,
    this.gpsTime,
  });

  factory BusPosList.fromJson(Map<String, dynamic> json) =>
      _$BusPosListFromJson(json);

  Map<String, dynamic> toJson() => _$BusPosListToJson(this);
}

@JsonSerializable()
class BusPosition {
  @JsonKey(name: 'Longitude')
  final double? longitude;
  @JsonKey(name: 'Latitude')
  final double? latitude;

  const BusPosition({
    this.longitude,
    this.latitude,
  });

  factory BusPosition.fromJson(Map<String, dynamic> json) =>
      _$BusPositionFromJson(json);

  Map<String, dynamic> toJson() => _$BusPositionToJson(this);
}
