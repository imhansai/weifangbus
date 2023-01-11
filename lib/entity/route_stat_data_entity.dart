import 'package:json_annotation/json_annotation.dart';

part 'route_stat_data_entity.g.dart';

@JsonSerializable()
class RouteStatDataEntity {
  final String? IsNewData;
  final int? RouteID;
  final String? RouteName;
  final String? RouteType;
  final List<Segmentlist>? SegmentList;
  final String? TimeStamp;
  final dynamic RouteMemo;
  final String? IsBRT;
  final dynamic BrotherRoute;
  final dynamic Ismainsub;

  const RouteStatDataEntity({
    this.IsNewData,
    this.RouteID,
    this.RouteName,
    this.RouteType,
    this.SegmentList,
    this.TimeStamp,
    this.RouteMemo,
    this.IsBRT,
    this.BrotherRoute,
    this.Ismainsub,
  });

  factory RouteStatDataEntity.fromJson(Map<String, dynamic> json) =>
      _$RouteStatDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RouteStatDataEntityToJson(this);
}

@JsonSerializable()
class Segmentlist {
  final int? SegmentID;
  final String? SegmentName;
  final String? FirstTime;
  final String? LastTime;
  final String? RoutePrice;
  final int? NormalTimeSpan;
  final int? PeakTimeSpan;
  final List<Stationlist>? StationList;
  final String? FirtLastShiftInfo;
  final String? Memos;
  final String? RunDirection;
  final String? Baidumapid;
  final String? Amapid;
  final String? DrawType;

  const Segmentlist({
    this.SegmentID,
    this.SegmentName,
    this.FirstTime,
    this.LastTime,
    this.RoutePrice,
    this.NormalTimeSpan,
    this.PeakTimeSpan,
    this.StationList,
    this.FirtLastShiftInfo,
    this.Memos,
    this.RunDirection,
    this.Baidumapid,
    this.Amapid,
    this.DrawType,
  });

  factory Segmentlist.fromJson(Map<String, dynamic> json) =>
      _$SegmentlistFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentlistToJson(this);
}

@JsonSerializable()
class Stationlist {
  final String? StationID;
  final String? StationName;
  final String? StationNO;
  final Stationpostion? StationPostion;
  final String? Stationmemo;
  final int? DualSerial;
  final int? StationSort;

  const Stationlist({
    this.StationID,
    this.StationName,
    this.StationNO,
    this.StationPostion,
    this.Stationmemo,
    this.DualSerial,
    this.StationSort,
  });

  factory Stationlist.fromJson(Map<String, dynamic> json) =>
      _$StationlistFromJson(json);

  Map<String, dynamic> toJson() => _$StationlistToJson(this);
}

@JsonSerializable()
class Stationpostion {
  final double? Longitude;
  final double? Latitude;

  const Stationpostion({
    this.Longitude,
    this.Latitude,
  });

  factory Stationpostion.fromJson(Map<String, dynamic> json) =>
      _$StationpostionFromJson(json);

  Map<String, dynamic> toJson() => _$StationpostionToJson(this);
}
