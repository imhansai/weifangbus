class RouteStatDataEntity {
	String routetype;
	String isbrt;
	String isnewdata;
	Null brotherroute;
	List<RouteStatDataSegmantlist> segmentlist;
	String routename;
	int routeid;
	String timestamp;
	Null routememo;
	Null ismainsub;

	RouteStatDataEntity({this.routetype, this.isbrt, this.isnewdata, this.brotherroute, this.segmentlist, this.routename, this.routeid, this.timestamp, this.routememo, this.ismainsub});

	RouteStatDataEntity.fromJson(Map<String, dynamic> json) {
		routetype = json['RouteType'];
		isbrt = json['IsBRT'];
		isnewdata = json['IsNewData'];
		brotherroute = json['BrotherRoute'];
		if (json['SegmentList'] != null) {
			segmentlist = new List<RouteStatDataSegmantlist>();
			(json['SegmentList'] as List).forEach((v) { segmentlist.add(new RouteStatDataSegmantlist.fromJson(v)); });
		}
		routename = json['RouteName'];
		routeid = json['RouteID'];
		timestamp = json['TimeStamp'];
		routememo = json['RouteMemo'];
		ismainsub = json['Ismainsub'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['RouteType'] = this.routetype;
		data['IsBRT'] = this.isbrt;
		data['IsNewData'] = this.isnewdata;
		data['BrotherRoute'] = this.brotherroute;
		if (this.segmentlist != null) {
      data['SegmentList'] = this.segmentlist.map((v) => v.toJson()).toList();
    }
		data['RouteName'] = this.routename;
		data['RouteID'] = this.routeid;
		data['TimeStamp'] = this.timestamp;
		data['RouteMemo'] = this.routememo;
		data['Ismainsub'] = this.ismainsub;
		return data;
	}
}

class RouteStatDataSegmantlist {
	String baidumapid;
	String firsttime;
	int peaktimespan;
	String segmentname;
	String routeprice;
	int segmentid;
	int normaltimespan;
	Null firtlastshiftinfo2;
	String amapid;
	String drawtype;
	String firtlastshiftinfo;
	String memos;
	String rundirection;
	List<RouteStatDataSegmantlistStationlist> stationlist;
	String lasttime;

	RouteStatDataSegmantlist({this.baidumapid, this.firsttime, this.peaktimespan, this.segmentname, this.routeprice, this.segmentid, this.normaltimespan, this.firtlastshiftinfo2, this.amapid, this.drawtype, this.firtlastshiftinfo, this.memos, this.rundirection, this.stationlist, this.lasttime});

	RouteStatDataSegmantlist.fromJson(Map<String, dynamic> json) {
		baidumapid = json['Baidumapid'];
		firsttime = json['FirstTime'];
		peaktimespan = json['PeakTimeSpan'];
		segmentname = json['SegmentName'];
		routeprice = json['RoutePrice'];
		segmentid = json['SegmentID'];
		normaltimespan = json['NormalTimeSpan'];
		firtlastshiftinfo2 = json['FirtLastShiftInfo2'];
		amapid = json['Amapid'];
		drawtype = json['DrawType'];
		firtlastshiftinfo = json['FirtLastShiftInfo'];
		memos = json['Memos'];
		rundirection = json['RunDirection'];
		if (json['StationList'] != null) {
			stationlist = new List<RouteStatDataSegmantlistStationlist>();
			(json['StationList'] as List).forEach((v) { stationlist.add(new RouteStatDataSegmantlistStationlist.fromJson(v)); });
		}
		lasttime = json['LastTime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Baidumapid'] = this.baidumapid;
		data['FirstTime'] = this.firsttime;
		data['PeakTimeSpan'] = this.peaktimespan;
		data['SegmentName'] = this.segmentname;
		data['RoutePrice'] = this.routeprice;
		data['SegmentID'] = this.segmentid;
		data['NormalTimeSpan'] = this.normaltimespan;
		data['FirtLastShiftInfo2'] = this.firtlastshiftinfo2;
		data['Amapid'] = this.amapid;
		data['DrawType'] = this.drawtype;
		data['FirtLastShiftInfo'] = this.firtlastshiftinfo;
		data['Memos'] = this.memos;
		data['RunDirection'] = this.rundirection;
		if (this.stationlist != null) {
      data['StationList'] = this.stationlist.map((v) => v.toJson()).toList();
    }
		data['LastTime'] = this.lasttime;
		return data;
	}
}

class RouteStatDataSegmantlistStationlist {
	String stationname;
	Null speed;
	int dualserial;
	String stationmemo;
	int stationsort;
	Null stationsectionlist;
	String stationno;
	RouteStatDataSegmentlistStationlistStationpostion stationpostion;
	String stationid;

	RouteStatDataSegmantlistStationlist({this.stationname, this.speed, this.dualserial, this.stationmemo, this.stationsort, this.stationsectionlist, this.stationno, this.stationpostion, this.stationid});

	RouteStatDataSegmantlistStationlist.fromJson(Map<String, dynamic> json) {
		stationname = json['StationName'];
		speed = json['Speed'];
		dualserial = json['DualSerial'];
		stationmemo = json['Stationmemo'];
		stationsort = json['StationSort'];
		stationsectionlist = json['StationSectionList'];
		stationno = json['StationNO'];
		stationpostion = json['StationPostion'] != null ? new RouteStatDataSegmentlistStationlistStationpostion.fromJson(json['StationPostion']) : null;
		stationid = json['StationID'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['StationName'] = this.stationname;
		data['Speed'] = this.speed;
		data['DualSerial'] = this.dualserial;
		data['Stationmemo'] = this.stationmemo;
		data['StationSort'] = this.stationsort;
		data['StationSectionList'] = this.stationsectionlist;
		data['StationNO'] = this.stationno;
		if (this.stationpostion != null) {
      data['StationPostion'] = this.stationpostion.toJson();
    }
		data['StationID'] = this.stationid;
		return data;
	}
}

class RouteStatDataSegmentlistStationlistStationpostion {
	double latitude;
	double longitude;

	RouteStatDataSegmentlistStationlistStationpostion({this.latitude, this.longitude});

	RouteStatDataSegmentlistStationlistStationpostion.fromJson(Map<String, dynamic> json) {
		latitude = json['Latitude'];
		longitude = json['Longitude'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Latitude'] = this.latitude;
		data['Longitude'] = this.longitude;
		return data;
	}
}
