import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/generated/json/base/json_field.dart';

class RouteRealTimeInfoEntity with JsonConvert<RouteRealTimeInfoEntity> {
  @JSONField(name: "RouteID")
  int routeID;
  @JSONField(name: "RunBusNum")
  int runBusNum;
  @JSONField(name: "RStaRealTInfoList")
  List<RouteRealTimeInfoRStaRealTInfoList> rStaRealTInfoList;
  @JSONField(name: "IsEnd")
  dynamic isEnd;
}

class RouteRealTimeInfoRStaRealTInfoList
    with JsonConvert<RouteRealTimeInfoRStaRealTInfoList> {
  @JSONField(name: "StationID")
  String stationID;
  @JSONField(name: "RStanum")
  int rStanum;
  @JSONField(name: "ExpArriveBusStaNum")
  int expArriveBusStaNum;
  @JSONField(name: "StopBusStaNum")
  int stopBusStaNum;
  @JSONField(name: "BusType")
  int busType;
  @JSONField(name: "MediaRouteName")
  dynamic mediaRouteName;
  dynamic islovebus;
}
