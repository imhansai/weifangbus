import 'package:json_annotation/json_annotation.dart';

part 'station_real_time_info_entity.g.dart';

@JsonSerializable()
class StationRealTimeInfoEntity {
  @JsonKey(name: 'RouteID')
  final int? routeID;
  @JsonKey(name: 'RealtimeInfoList')
  final List<RealtimeInfoList>? realtimeInfoList;
  @JsonKey(name: 'StationID')
  final String? stationID;
  @JsonKey(name: 'StationName')
  final String? stationName;
  @JsonKey(name: 'RouteName')
  final String? routeName;
  @JsonKey(name: 'EndStaInfo')
  final String? endStaInfo;
  @JsonKey(name: 'FirstTime')
  final String? firstTime;
  @JsonKey(name: 'LastTime')
  final String? lastTime;
  @JsonKey(name: 'FirtLastShiftInfo')
  final String? firstLastShiftInfo;
  @JsonKey(name: 'FirtLastShiftInfo2')
  final dynamic firstLastShiftInfo2;
  @JsonKey(name: 'MainSubRouteID')
  final dynamic mainSubRouteID;
  @JsonKey(name: 'DepartureState')
  final String? departureState;
  @JsonKey(name: 'ServerTime')
  final dynamic serverTime;
  @JsonKey(name: 'Sortinfo')
  final int? sortInfo;
  @JsonKey(name: 'Sortinfo2')
  final int? sortInfo2;

  const StationRealTimeInfoEntity({
    this.routeID,
    this.realtimeInfoList,
    this.stationID,
    this.stationName,
    this.routeName,
    this.endStaInfo,
    this.firstTime,
    this.lastTime,
    this.firstLastShiftInfo,
    this.firstLastShiftInfo2,
    this.mainSubRouteID,
    this.departureState,
    this.serverTime,
    this.sortInfo,
    this.sortInfo2,
  });

  factory StationRealTimeInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$StationRealTimeInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StationRealTimeInfoEntityToJson(this);
}

@JsonSerializable()
class RealtimeInfoList {
  @JsonKey(name: 'BusID')
  final String? busID;
  @JsonKey(name: 'BusName')
  final String? busName;
  @JsonKey(name: 'ArriveStaName')
  final String? arriveStaName;
  @JsonKey(name: 'ArriveTime')
  final String? arriveTime;
  @JsonKey(name: 'BusPostion')
  final BusPosition? busPosition;
  @JsonKey(name: 'StationID')
  final String? stationID;
  @JsonKey(name: 'SpaceNum')
  final int? spaceNum;
  @JsonKey(name: 'RunTime')
  final int? runTime;
  @JsonKey(name: 'Distance')
  final String? distance;
  @JsonKey(name: 'ISLast')
  final int? iSLast;
  @JsonKey(name: 'ForeCastInfo1')
  final String? foreCastInfo1;
  @JsonKey(name: 'ForeCastInfo2')
  final String? foreCastInfo2;
  @JsonKey(name: 'Areaconglevel')
  final String? areaCongLevel;
  @JsonKey(name: 'Temperature')
  final String? temperature;
  @JsonKey(name: 'Productid')
  final int? productId;
  @JsonKey(name: 'SubRouteID')
  final int? subRouteID;
  @JsonKey(name: 'LeaveOrStop')
  final int? leaveOrStop;
  @JsonKey(name: 'DepartureState')
  final String? departureState;
  @JsonKey(name: 'SortTime')
  final double? sortTime;

  const RealtimeInfoList({
    this.busID,
    this.busName,
    this.arriveStaName,
    this.arriveTime,
    this.busPosition,
    this.stationID,
    this.spaceNum,
    this.runTime,
    this.distance,
    this.iSLast,
    this.foreCastInfo1,
    this.foreCastInfo2,
    this.areaCongLevel,
    this.temperature,
    this.productId,
    this.subRouteID,
    this.leaveOrStop,
    this.departureState,
    this.sortTime,
  });

  factory RealtimeInfoList.fromJson(Map<String, dynamic> json) =>
      _$RealtimeInfoListFromJson(json);

  Map<String, dynamic> toJson() => _$RealtimeInfoListToJson(this);
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
