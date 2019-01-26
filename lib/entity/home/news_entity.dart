class NewsEntity {
	List<News> news;

	NewsEntity({this.news});

	NewsEntity.fromJson(Map<String, dynamic> json) {
		if (json['news'] != null) {
			news = new List<News>();
			json['news'].forEach((v) { news.add(new News.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class News {
	String id;
	String title;
	String content;
	String realeasetime;
	String routeid;
	String stationid;
	String realeasedatetime;
	String contenthtml;
	Null istop1;
	Null isscroll;

	News({this.id, this.title, this.content, this.realeasetime, this.routeid, this.stationid, this.realeasedatetime, this.contenthtml, this.istop1, this.isscroll});

	News.fromJson(Map<String, dynamic> json) {
		id = json['ID'];
		title = json['Title'];
		content = json['Content'];
		realeasetime = json['RealeaseTime'];
		routeid = json['RouteID'];
		stationid = json['StationID'];
		realeasedatetime = json['RealeaseDateTime'];
		contenthtml = json['ContentHtml'];
		istop1 = json['istop1'];
		isscroll = json['isscroll'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ID'] = this.id;
		data['Title'] = this.title;
		data['Content'] = this.content;
		data['RealeaseTime'] = this.realeasetime;
		data['RouteID'] = this.routeid;
		data['StationID'] = this.stationid;
		data['RealeaseDateTime'] = this.realeasedatetime;
		data['ContentHtml'] = this.contenthtml;
		data['istop1'] = this.istop1;
		data['isscroll'] = this.isscroll;
		return data;
	}
}
