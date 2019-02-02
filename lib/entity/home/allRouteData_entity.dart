class AllroutedataEntity {
	String isnewdata;
	List<Routelist> routelist;
	String timestamp;

	AllroutedataEntity({this.isnewdata, this.routelist, this.timestamp});

	AllroutedataEntity.fromJson(Map<String, dynamic> json) {
		isnewdata = json['IsNewData'];
		if (json['RouteList'] != null) {
			routelist = new List<Routelist>();
			json['RouteList'].forEach((v) { routelist.add(new Routelist.fromJson(v)); });
		}
		timestamp = json['TimeStamp'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['IsNewData'] = this.isnewdata;
		if (this.routelist != null) {
      data['RouteList'] = this.routelist.map((v) => v.toJson()).toList();
    }
		data['TimeStamp'] = this.timestamp;
		return data;
	}
}

class Routelist {
	int routeid;
	String routename;
	Null ishavesubroutecombine;
	String routenameext;

	Routelist({this.routeid, this.routename, this.ishavesubroutecombine, this.routenameext});

	Routelist.fromJson(Map<String, dynamic> json) {
		routeid = json['RouteID'];
		routename = json['RouteName'];
		ishavesubroutecombine = json['IsHaveSubRouteCombine'];
		routenameext = json['RouteNameExt'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['RouteID'] = this.routeid;
		data['RouteName'] = this.routename;
		data['IsHaveSubRouteCombine'] = this.ishavesubroutecombine;
		data['RouteNameExt'] = this.routenameext;
		return data;
	}
}
