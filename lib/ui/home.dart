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
      body: new Container(
        child: new Column(
          children: <Widget>[
            /// 轮播图
            new Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: new BorderRadius.all(new Radius.circular(_radius)),
                    child: new FadeInImage.assetNetwork(
                      placeholder: 'assets/home/placeholder.png',
                      image:
                          "http://122.4.254.30:3009//erp//InfoIsland//App//banner%E7%AE%A1%E7%90%86_170724112250_%E5%85%B3%E6%B3%A8%E5%B8%82%E6%B0%91%E5%87%BA%E8%A1%8C.jpg",
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: Duration(seconds: 1),
                      fit: BoxFit.fill,
                    ),
                  );
                },
                index: 0,
                autoplay: true,
                itemCount: 4,
                viewportFraction: 0.8,
                scale: 0.9,
                duration: 300,
                autoplayDelay: 3000,
                pagination: new SwiperPagination(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
