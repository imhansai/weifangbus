import 'package:weifangbus/entity/home/headline_entity.dart';

class StartUpBasicInfoEntity {
  List<Headline> headline;
  List<Slideshow> slideshow;
  List<Loginpic> loginpic;

  StartUpBasicInfoEntity({this.headline, this.slideshow, this.loginpic});

  StartUpBasicInfoEntity.fromJson(Map<String, dynamic> json) {
    if (json['HeadLine'] != null) {
      headline = List<Headline>();
      json['HeadLine'].forEach((v) {
        headline.add(Headline.fromJson(v));
      });
    }
    if (json['SlideShow'] != null) {
      slideshow = List<Slideshow>();
      json['SlideShow'].forEach((v) {
        slideshow.add(Slideshow.fromJson(v));
      });
    }
    if (json['LoginPic'] != null) {
      loginpic = List<Loginpic>();
      json['LoginPic'].forEach((v) {
        loginpic.add(Loginpic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bannerid'] = this.bannerid;
    data['name'] = this.name;
    data['title'] = this.title;
    data['bannerurl'] = this.bannerurl;
    data['linkurl'] = this.linkurl;
    data['bannerusefor'] = this.bannerusefor;
    return data;
  }
}
