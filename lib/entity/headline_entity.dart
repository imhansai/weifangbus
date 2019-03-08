class Headline {
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

  Headline(
      {this.id,
        this.title,
        this.content,
        this.realeasetime,
        this.routeid,
        this.stationid,
        this.realeasedatetime,
        this.contenthtml,
        this.istop1,
        this.isscroll});

  Headline.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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