import 'package:weifangbus/generated/json/base/json_convert_content.dart';
import 'package:weifangbus/generated/json/base/json_field.dart';

class StationRealTimeInfoEntity with JsonConvert<StationRealTimeInfoEntity> {
	@JSONField(name: "RouteID")
	double routeID;
	@JSONField(name: "RealtimeInfoList")
	List<StationRealTimeInfoRealtimeInfoList> realtimeInfoList;
	@JSONField(name: "StationID")
	String stationID;
	@JSONField(name: "StationName")
	String stationName;
	@JSONField(name: "RouteName")
	String routeName;
	@JSONField(name: "EndStaInfo")
	String endStaInfo;
	@JSONField(name: "FirstTime")
	String firstTime;
	@JSONField(name: "LastTime")
	String lastTime;
	@JSONField(name: "FirtLastShiftInfo")
	String firtLastShiftInfo;
	@JSONField(name: "FirtLastShiftInfo2")
	dynamic firtLastShiftInfo2;
	@JSONField(name: "MainSubRouteID")
	dynamic mainSubRouteID;
	@JSONField(name: "RoutePrice")
	String routePrice;
}

class StationRealTimeInfoRealtimeInfoList with JsonConvert<StationRealTimeInfoRealtimeInfoList> {
	@JSONField(name: "BusID")
	String busID;
	@JSONField(name: "BusName")
	String busName;
	@JSONField(name: "ArriveStaName")
	String arriveStaName;
	@JSONField(name: "ArriveTime")
	String arriveTime;
	@JSONField(name: "BusPostion")
	StationRealTimeInfoRealtimeInfoListBusPostion busPostion;
	@JSONField(name: "StationID")
	String stationID;
	@JSONField(name: "SpaceNum")
	double spaceNum;
	@JSONField(name: "RunTime")
	double runTime;
	@JSONField(name: "Distance")
	dynamic distance;
	@JSONField(name: "ISLast")
	double iSLast;
	@JSONField(name: "SendTime")
	dynamic sendTime;
	@JSONField(name: "ForeCastInfo1")
	String foreCastInfo1;
	@JSONField(name: "ForeCastInfo2")
	String foreCastInfo2;
	@JSONField(name: "Areaconglevel")
	dynamic areaconglevel;
	@JSONField(name: "Bussid")
	dynamic bussid;
	@JSONField(name: "Temperature")
	dynamic temperature;
	@JSONField(name: "Productid")
	double productid;
	@JSONField(name: "SubRouteID")
	double subRouteID;
	@JSONField(name: "LeaveOrStop")
	double leaveOrStop;
	dynamic islovebus;
}

class StationRealTimeInfoRealtimeInfoListBusPostion with JsonConvert<StationRealTimeInfoRealtimeInfoListBusPostion> {
	@JSONField(name: "Longitude")
	double longitude;
	@JSONField(name: "Latitude")
	double latitude;
}
