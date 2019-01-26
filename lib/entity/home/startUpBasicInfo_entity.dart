class StartUpBasicInfoEntity {
  List<Headline> headline;
  List<Slideshow> slideshow;
  List<Loginpic> loginpic;

  StartUpBasicInfoEntity({this.headline, this.slideshow, this.loginpic});

  StartUpBasicInfoEntity.fromJson(Map<String, dynamic> json) {
    if (json['HeadLine'] != null) {
      headline = new List<Headline>();
      json['HeadLine'].forEach((v) {
        headline.add(new Headline.fromJson(v));
      });
    }
    if (json['SlideShow'] != null) {
      slideshow = new List<Slideshow>();
      json['SlideShow'].forEach((v) {
        slideshow.add(new Slideshow.fromJson(v));
      });
    }
    if (json['LoginPic'] != null) {
      loginpic = new List<Loginpic>();
      json['LoginPic'].forEach((v) {
        loginpic.add(new Loginpic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.headline != null) {
      data['HeadLine'] = this.headline.map((v) => v.toJson()).toList();
    }
    if (this.slideshow != null) {
      data['SlideShow'] = this.slideshow.map((v) => v.toJson()).toList();
    }
    if (this.loginpic != null) {
      data['LoginPic'] = this.loginpic.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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

class Slideshow {
  String bannerid;
  String name;
  String title;
  String bannerurl;
  String linkurl;
  String bannerusefor;

  Slideshow({this.bannerid, this.name, this.title, this.bannerurl, this.linkurl, this.bannerusefor});

  Slideshow.fromJson(Map<String, dynamic> json) {
    bannerid = json['bannerid'];
    name = json['name'];
    title = json['title'];
    bannerurl = json['bannerurl'];
    linkurl = json['linkurl'];
    bannerusefor = json['bannerusefor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerid'] = this.bannerid;
    data['name'] = this.name;
    data['title'] = this.title;
    data['bannerurl'] = this.bannerurl;
    data['linkurl'] = this.linkurl;
    data['bannerusefor'] = this.bannerusefor;
    return data;
  }
}

class Loginpic {
  String bannerid;
  String name;
  String title;
  String bannerurl;
  String linkurl;
  String bannerusefor;

  Loginpic({this.bannerid, this.name, this.title, this.bannerurl, this.linkurl, this.bannerusefor});

  Loginpic.fromJson(Map<String, dynamic> json) {
    bannerid = json['bannerid'];
    name = json['name'];
    title = json['title'];
    bannerurl = json['bannerurl'];
    linkurl = json['linkurl'];
    bannerusefor = json['bannerusefor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerid'] = this.bannerid;
    data['name'] = this.name;
    data['title'] = this.title;
    data['bannerurl'] = this.bannerurl;
    data['linkurl'] = this.linkurl;
    data['bannerusefor'] = this.bannerusefor;
    return data;
  }
}
