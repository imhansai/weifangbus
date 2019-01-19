import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:weifangbus/entity/startUpBasicInfo_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 初始页json数据实体类
  var _startupbasicinfoEntity = new StartupbasicinfoEntity();

  // 轮播图初始列表
  List<Slideshow> _slideShows = new List();

  // 资讯信息
  List<Headline> _headLines = new List();

  // 请求首页数据
  Future getStartUpBasicInfoEntity() async {
    try {
      Response response;
      var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
      print('uri::: ' + uri);
      response = await dio.get(uri);
      _startupbasicinfoEntity = EntityFactory.generateOBJ<StartupbasicinfoEntity>(response.data);
      print('请求完毕');
      // 设置数据，重绘 ui
      setState(() {
        _slideShows = _startupbasicinfoEntity.slideshow;
        _headLines = _startupbasicinfoEntity.headline;
      });
    } catch (e) {
      print('获取 startupbasicinfoEntity 出错::: ' + e);
    }
  }

  @override
  void initState() {
    getStartUpBasicInfoEntity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      body: new Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              sliver: SliverFixedExtentList(
                itemExtent: 180.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return new Container(
                      child: _swiper(),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              sliver: SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return new Container(
                      child: _information(),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: new SliverGrid(
                //Grid
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 列数
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.0,
                ),
                delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return new Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: new Text('grid item $index'),
                    );
                  },
                  childCount: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 轮播图
  Widget _swiper() {
    if (_slideShows.length > 0) {
      return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10)),
            child: new FadeInImage.assetNetwork(
              placeholder: 'assets/home/placeholder.png',
              image: _slideShows[index].bannerurl,
              fadeInCurve: Curves.easeIn,
              fadeInDuration: Duration(seconds: 1),
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: _slideShows.length,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        duration: 300,
        autoplayDelay: 3000,
        pagination: new SwiperPagination(),
        onTap: (int index) {
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("图片名称"),
              ),
              body: new Center(
                child: new Text(_slideShows[index].name),
              ),
            );
          }));
        },
      );
    }
  }

  // 资讯信息
  Widget _information() {
    if (_headLines.length > 0) {
      return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
              borderRadius: new BorderRadius.all(new Radius.circular(10)),
              child: new Text('资讯:' + _headLines[index].title));
        },
        scrollDirection: Axis.vertical,
        itemCount: _headLines.length,
        autoplay: true,
        duration: 300,
        autoplayDelay: 3000,
        onTap: (int index) {
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("资讯详情"),
              ),
              body: new HtmlWidget(_headLines[index].content),
            );
          }));
        },
      );
    }
  }
}
