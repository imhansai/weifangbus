import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weifangbus/entity/startUpBasicInfo_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/ui/informationDetail.dart';
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
  getStartUpBasicInfoEntity() async {
    try {
      var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
      print('uri::: ' + uri);
      Response response = await dio.get(uri);
      _startupbasicinfoEntity = EntityFactory.generateOBJ<StartupbasicinfoEntity>(response.data);
      print('请求 _startupbasicinfoEntity 完毕,设置数据，重绘 ui');
      setState(() {
        _slideShows = _startupbasicinfoEntity.slideshow;
        _headLines = _startupbasicinfoEntity.headline;
      });
    } catch (e) {
      print('获取 _startupbasicinfoEntity 出错::: ' + e);
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
                      child: _loopPicWidget(),
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
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: _informationWidget(),
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
                      color: Colors.blue,
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
  Widget _loopPicWidget() {
    if (_slideShows.length > 0) {
      return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: _slideShows[index].bannerurl,
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
      );
    }
  }

  // 资讯信息
  Widget _informationWidget() {
    bool autoplay = _headLines.length > 1;
    if (_headLines.length > 0) {
      return new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return _informationItemWidget(index);
        },
        scrollDirection: Axis.vertical,
        itemCount: _headLines.length,
        autoplay: autoplay,
        duration: 300,
        autoplayDelay: 3000,
        onTap: (int index) {
          final Headline headLine = _headLines[index];
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
            return InformationDetail(
              headLine: headLine,
            );
          }));
        },
      );
    }
  }

  Widget _informationItemWidget(int index) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrangeAccent), borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text(
            ' 资讯 ',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        Expanded(
          child: new Text(
            ' ' + _headLines[index].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
