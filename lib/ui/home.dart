import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _radius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      body: new Column(
        children: <Widget>[
          /// 轮播图
          new Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, index);
              },
              index: 0,
              autoplay: true,
              itemCount: 4,
              viewportFraction: 0.8,
              scale: 0.9,
              duration: 300,
              autoplayDelay: 5000,
              pagination: new SwiperPagination(),
            ),
          ),
        ],
      ),
    );
  }

  /// 为轮播图片加圆角
  Widget _buildItem(BuildContext context, int index) {
    /// ClipRRect: https://docs.flutter.io/flutter/widgets/ClipRRect-class.html
    return ClipRRect(
      borderRadius: new BorderRadius.all(new Radius.circular(_radius)),
      child: new Image.network(
        "http://via.placeholder.com/288x188",
        fit: BoxFit.fill,
      ),
    );
  }
}
