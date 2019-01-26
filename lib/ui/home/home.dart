import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weifangbus/entity/home/startUpBasicInfo_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/ui/home/news_detail.dart';
import 'package:weifangbus/ui/home/news_list.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/fontUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<MenuEntity> menuEntityList = List();

  // 初始页json数据实体类
  var _startUpBasicInfoEntity;

  // 请求首页数据
  Future<StartUpBasicInfoEntity> getStartUpBasicInfoEntity() async {
    try {
      var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
      print('uri::: ' + uri);
      Response response = await dio.get(uri);
      var startUpBasicInfoEntity = EntityFactory.generateOBJ<StartUpBasicInfoEntity>(response.data);
      print('请求 _startUpBasicInfoEntity 完毕');
      return startUpBasicInfoEntity;
    } catch (e) {
      print('获取 _startupbasicinfoEntity 出错::: ' + e);
      return StartUpBasicInfoEntity();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    MenuEntity lineInquiry = MenuEntity(Colors.lightBlue, MyIcons.lineInquiry, '线路查询', null);
    menuEntityList.add(lineInquiry);
    MenuEntity guide = MenuEntity(Colors.lightGreen, MyIcons.guide, '导乘', null);
    menuEntityList.add(guide);
    MenuEntity news = MenuEntity(Colors.orangeAccent, MyIcons.news, '资讯', NewsListPage());
    menuEntityList.add(news);
    _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
  }

  reTry() {
    setState(() {
      _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: FutureBuilder(
        future: _startUpBasicInfoEntity,
        builder: (context, result) {
          if (result.connectionState == ConnectionState.active || result.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setWidth(100),
                    child: SpinKitRotatingPlain(
                      color: Colors.lightGreen,
                      size: ScreenUtil().setWidth(100),
                    ),
                  ),
                  Container(
                    child: Text('加载中...'),
                  )
                ],
              ),
            );
          }

          if (result.connectionState == ConnectionState.done) {
            if (result.hasData) {
              var startUpBasicInfoEntity = result.data as StartUpBasicInfoEntity;
              return Container(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(0)),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              height: ScreenUtil().setHeight(609), // 435 + 174
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(0),
                                        ScreenUtil().setWidth(30),
                                        ScreenUtil().setWidth(0),
                                        ScreenUtil().setWidth(30),
                                      ),
                                      child: Swiper(
                                        itemBuilder: (BuildContext context, int index) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              placeholder: Center(
                                                child: SpinKitFadingCube(
                                                  color: Theme.of(context).primaryColor,
                                                  size: ScreenUtil().setWidth(80),
                                                ),
                                              ),
                                              imageUrl: startUpBasicInfoEntity.slideshow[index].bannerurl,
                                              fadeInCurve: Curves.easeIn,
                                              fadeInDuration: Duration(seconds: 1),
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        },
                                        itemCount: startUpBasicInfoEntity.slideshow.length,
                                        viewportFraction: 0.9,
                                        scale: 0.95,
                                        autoplay: true,
                                        duration: 300,
                                        autoplayDelay: 3000,
                                      ),
                                    ),
                                    flex: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(30),
                                          ScreenUtil().setWidth(5),
                                          ScreenUtil().setWidth(30),
                                          ScreenUtil().setWidth(5),
                                        ),
                                        child: Swiper(
                                          itemBuilder: (BuildContext context, int index) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.deepOrangeAccent),
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    ' 资讯 ',
                                                    style: TextStyle(
                                                      color: Colors.deepOrangeAccent,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    ' ' + startUpBasicInfoEntity.headline[index].title,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          scrollDirection: Axis.vertical,
                                          itemCount: startUpBasicInfoEntity.headline.length,
                                          autoplay: startUpBasicInfoEntity.headline.length > 1,
                                          duration: 300,
                                          autoplayDelay: 3000,
                                          onTap: (int index) {
                                            final Headline headLine = startUpBasicInfoEntity.headline[index];
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return InformationDetail(
                                                    headLine: headLine,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: ScreenUtil().setWidth(10),
                          crossAxisSpacing: ScreenUtil().setWidth(10),
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(170),
                                      height: ScreenUtil().setHeight(170),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: menuEntityList[index].color,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black54,
                                                offset: Offset(
                                                  ScreenUtil().setWidth(2),
                                                  ScreenUtil().setWidth(2),
                                                ),
                                                blurRadius: 4.0),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(
                                            menuEntityList[index].icon,
                                            size: ScreenUtil().setWidth(80),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                                      child: Text(
                                        menuEntityList[index].menuText,
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(40),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print('点击了::: $index');
                                // todo 先做资讯信息列表
                                if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return menuEntityList[index].onTapWidget;
                                      },
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          childCount: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (result.hasError) {
              return Center(
                child: RaisedButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("请检查网络连接后重试"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: reTry,
                ),
              );
            }
          }
        },
      ),
    );
  }
}

// 菜单实体类
class MenuEntity {
  Color color;
  IconData icon;
  String menuText;
  Widget onTapWidget;

  MenuEntity(this.color, this.icon, this.menuText, this.onTapWidget);
}
