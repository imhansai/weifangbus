class NewsEntity {
	Null istop1;
	String realeasetime;
	String content;
	String contenthtml;
	String title;
	Null isscroll;
	String id;
	String routeid;
	String realeasedatetime;
	String stationid;

	NewsEntity({this.istop1, this.realeasetime, this.content, this.contenthtml, this.title, this.isscroll, this.id, this.routeid, this.realeasedatetime, this.stationid});

	NewsEntity.fromJson(Map<String, dynamic> json) {
		istop1 = json['istop1'];
		realeasetime = json['RealeaseTime'];
		content = json['Content'];
		contenthtml = json['ContentHtml'];
		title = json['Title'];
		isscroll = json['isscroll'];
		id = json['ID'];
		routeid = json['RouteID'];
		realeasedatetime = json['RealeaseDateTime'];
		stationid = json['StationID'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['istop1'] = this.istop1;
		data['RealeaseTime'] = this.realeasetime;
		data['Content'] = this.content;
		data['ContentHtml'] = this.contenthtml;
		data['Title'] = this.title;
		data['isscroll'] = this.isscroll;
		data['ID'] = this.id;
		data['RouteID'] = this.routeid;
		data['RealeaseDateTime'] = this.realeasedatetime;
		data['StationID'] = this.stationid;
		return data;
	}
}
