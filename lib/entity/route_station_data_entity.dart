import 'package:json_annotation/json_annotation.dart';

part 'route_station_data_entity.g.dart';

@JsonSerializable()
class RouteStationDataEntity {
  @JsonKey(name: 'IsNewData')
  final String? isNewData;
  @JsonKey(name: 'RouteID')
  final int? routeID;
  @JsonKey(name: 'RouteName')
  final String? routeName;
  @JsonKey(name: 'RouteType')
  final String? routeType;
  @JsonKey(name: 'SegmentList')
  final List<SegmentList>? segmentList;
  @JsonKey(name: 'TimeStamp')
  final String? timeStamp;
  @JsonKey(name: 'RouteMemo')
  final dynamic routeMemo;
  @JsonKey(name: 'IsBRT')
  final String? isBRT;
  @JsonKey(name: 'BrotherRoute')
  final dynamic brotherRoute;
  @JsonKey(name: 'Ismainsub')
  final String? isMainSub;

  const RouteStationDataEntity({
    this.isNewData,
    this.routeID,
    this.routeName,
    this.routeType,
    this.segmentList,
    this.timeStamp,
    this.routeMemo,
    this.isBRT,
    this.brotherRoute,
    this.isMainSub,
  });

  factory RouteStationDataEntity.fromJson(Map<String, dynamic> json) =>
      _$RouteStationDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RouteStationDataEntityToJson(this);
}

@JsonSerializable()
class SegmentList {
  @JsonKey(name: 'SegmentID')
  final int? segmentID;
  @JsonKey(name: 'SegmentName')
  final String? segmentName;
  @JsonKey(name: 'FirstTime')
  final String? firstTime;
  @JsonKey(name: 'LastTime')
  final String? lastTime;
  @JsonKey(name: 'RoutePrice')
  final String? routePrice;
  @JsonKey(name: 'NormalTimeSpan')
  final int? normalTimeSpan;
  @JsonKey(name: 'PeakTimeSpan')
  final double? peakTimeSpan;
  @JsonKey(name: 'StationList')
  final List<StationList>? stationList;
  @JsonKey(name: 'FirtLastShiftInfo')
  final String? firstLastShiftInfo;
  @JsonKey(name: 'RunDirection')
  final String? runDirection;
  @JsonKey(name: 'Baidumapid')
  final String? baiduMapId;
  @JsonKey(name: 'DrawType')
  final String? drawType;

  const SegmentList({
    this.segmentID,
    this.segmentName,
    this.firstTime,
    this.lastTime,
    this.routePrice,
    this.normalTimeSpan,
    this.peakTimeSpan,
    this.stationList,
    this.firstLastShiftInfo,
    this.runDirection,
    this.baiduMapId,
    this.drawType,
  });

  factory SegmentList.fromJson(Map<String, dynamic> json) =>
      _$SegmentListFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentListToJson(this);
}

@JsonSerializable()
class StationList {
  @JsonKey(name: 'StationID')
  final String? stationID;
  @JsonKey(name: 'StationName')
  final String? stationName;
  @JsonKey(name: 'StationNO')
  final String? stationNO;
  @JsonKey(name: 'StationPostion')
  final StationPosition? stationPosition;
  @JsonKey(name: 'DualSerial')
  final int? dualSerial;
  @JsonKey(name: 'Sngserialid')
  final int? sngSerialId;
  @JsonKey(name: 'StationSort')
  final int? stationSort;
  @JsonKey(name: 'StationSectionList')
  final List<StationSectionList>? stationSectionList;

  const StationList({
    this.stationID,
    this.stationName,
    this.stationNO,
    this.stationPosition,
    this.dualSerial,
    this.sngSerialId,
    this.stationSort,
    this.stationSectionList,
  });

  factory StationList.fromJson(Map<String, dynamic> json) =>
      _$StationListFromJson(json);

  Map<String, dynamic> toJson() => _$StationListToJson(this);
}

@JsonSerializable()
class StationPosition {
  @JsonKey(name: 'Longitude')
  final double? longitude;
  @JsonKey(name: 'Latitude')
  final double? latitude;

  const StationPosition({
    this.longitude,
    this.latitude,
  });

  factory StationPosition.fromJson(Map<String, dynamic> json) =>
      _$StationPositionFromJson(json);

  Map<String, dynamic> toJson() => _$StationPositionToJson(this);
}

@JsonSerializable()
class StationSectionList {
  @JsonKey(name: 'StationID')
  final String? stationID;
  @JsonKey(name: 'SectionPostion')
  final SectionPosition? sectionPosition;
  @JsonKey(name: 'DegreeOfCongestion')
  final String? degreeOfCongestion;
  @JsonKey(name: 'Speed')
  final String? speed;

  const StationSectionList({
    this.stationID,
    this.sectionPosition,
    this.degreeOfCongestion,
    this.speed,
  });

  factory StationSectionList.fromJson(Map<String, dynamic> json) =>
      _$StationSectionListFromJson(json);

  Map<String, dynamic> toJson() => _$StationSectionListToJson(this);
}

@JsonSerializable()
class SectionPosition {
  @JsonKey(name: 'Longitude')
  final double? longitude;
  @JsonKey(name: 'Latitude')
  final double? latitude;

  const SectionPosition({
    this.longitude,
    this.latitude,
  });

  factory SectionPosition.fromJson(Map<String, dynamic> json) =>
      _$SectionPositionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionPositionToJson(this);
}
