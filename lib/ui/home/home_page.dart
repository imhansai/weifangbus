import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/headline_entity.dart';
import 'package:weifangbus/entity/startup_basic_info_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/ui/home/guide.dart';
import 'package:weifangbus/ui/home/news_detail.dart';
import 'package:weifangbus/ui/home/news_list.dart';
import 'package:weifangbus/ui/home/route_detail.dart';
import 'package:weifangbus/ui/home/search_input.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/fontUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setMenuEntityList();
    _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
    getAllRoute();
  }

  // 菜单项
  List<MenuEntity> menuEntityList;

  // 初始页json数据实体类
  Future<StartUpBasicInfoEntity> _startUpBasicInfoEntity;

  // 资讯列表
  List<Headline> _showNewsList;

  // 所有线路
  List<MaterialSearchResult<String>> allRouteList;

  // 刷新资讯信息
  void _handleNewsListOnRefresh(List<Headline> newsList) {
    print("父 widget 设置状态");
    setState(() {
      _showNewsList = newsList;
    });
  }

  // 展示 SnackBar
  void showSnackBar(String snackStr) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  // 设置菜单
  void setMenuEntityList() {
    menuEntityList = List();
    MenuEntity lineInquiry = MenuEntity(
      Colors.lightGreen,
      MyIcons.lineInquiry,
      "线路查询",
      () {
        Navigator.push(
          context,
          MaterialPageRoute<String>(
            builder: (BuildContext context) {
              return Material(
                child: MaterialSearch<String>(
                  barBackgroundColor: Theme.of(context).primaryColor,
                  placeholder: "搜索线路",
                  results: allRouteList,
                  filter: (dynamic value, String criteria) {
                    return value.toLowerCase().trim().contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                  },
                ),
              );
            },
          ),
        );
      },
    );
    menuEntityList.add(lineInquiry);
    MenuEntity guide = MenuEntity(
      Colors.lightBlue,
      MyIcons.guide,
      '导乘',
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Guide();
            },
          ),
        );
      },
    );
    menuEntityList.add(guide);
    MenuEntity news = MenuEntity(
      Colors.orangeAccent,
      MyIcons.news,
      '资讯',
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsListPage(
                showNewsList: _showNewsList,
                onChanged: _handleNewsListOnRefresh,
              );
            },
          ),
        );
      },
    );
    menuEntityList.add(news);
  }

  // 请求首页数据
  Future<StartUpBasicInfoEntity> getStartUpBasicInfoEntity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
        Response response = await dio.get(uri);
        var startUpBasicInfoEntity = EntityFactory.generateOBJ<StartUpBasicInfoEntity>(response.data);
        print("请求首页数据完毕");
        if (startUpBasicInfoEntity == null) {
          startUpBasicInfoEntity = StartUpBasicInfoEntity();
        }
        if (startUpBasicInfoEntity.slideshow == null) {
          startUpBasicInfoEntity.slideshow = List();
        }
        _showNewsList = startUpBasicInfoEntity.headline;
        if (_showNewsList == null) {
          _showNewsList = List();
        }
        return startUpBasicInfoEntity;
      } on DioError catch (e) {
        print('请求首页数据出错::: $e');
        showSnackBar('请求数据失败，请尝试切换网络后重试!');
        return Future.error(e);
      }
    } else {
      showSnackBar('设备未连接到任何网络,请连接网络后重试!');
      return Future.value(null);
    }
  }

  void getAllRoute() async {
    try {
      Response response;
      var uri = "/BusService/Require_AllRouteData/?" + getSignString();
      response = await dio.get(uri);
      AllroutedataEntity allRouteDataEntity = EntityFactory.generateOBJ<AllroutedataEntity>(response.data);
      print("请求全部线路完成");
      setState(() {
        allRouteList = allRouteDataEntity.routelist
            .map((item) => MaterialSearchResult<String>(
                  value: item.routename,
                  icon: Icons.directions_bus,
                  text: item.routenameext,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return RouteDetail(
                            title: item.routenameext,
                            routeId: item.routeid,
                          );
                        },
                      ),
                    );
                  },
                ))
            .toList();
      });
    } catch (e) {
      print('请求出现问题::: $e');
    }
  }

  // 重试处理
  reTry() {
    setState(() {
      _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
      getAllRoute();
    });
  }

  // 出现错误展示的控件
  Widget reTryWidget() {
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

  // 搜索栏
  Widget searchBar(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: ScreenUtil().setWidth(25),
                left: ScreenUtil().setWidth(25),
              ),
              child: Icon(
                Icons.search,
                size: ScreenUtil().setWidth(60),
                color: Theme.of(context).accentColor,
              ),
            ),
            Expanded(
              child: MaterialSearchInput(
                placeholder: "搜索线路",
                results: allRouteList,
                filter: (dynamic value, String criteria) {
                  return value.toLowerCase().trim().contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: searchBar(context),
      ),
      body: FutureBuilder<StartUpBasicInfoEntity>(
        future: _startUpBasicInfoEntity,
        builder: (BuildContext context, AsyncSnapshot<StartUpBasicInfoEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              // return Text('Awaiting result...');
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
            case ConnectionState.done:
              if (snapshot.hasError) {
                // return Text('Error: ${snapshot.error}');
                return reTryWidget();
              }
              // return Text('Result: ${snapshot.data}');
              if (snapshot.hasData) {
                var startUpBasicInfoEntity = snapshot.data as StartUpBasicInfoEntity;
                // 是否展示轮播图
                var canShowSlideShow = false;
                // 是否展示资讯信息
                var canShowHeadLine = false;
                if (startUpBasicInfoEntity.slideshow.length > 0) {
                  canShowSlideShow = true;
                }
                if (_showNewsList.length > 0) {
                  canShowHeadLine = true;
                }
                return Container(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      // 轮播图 + 资讯
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
                                        child: canShowSlideShow
                                            ? Swiper(
                                                itemBuilder: (BuildContext context, int index) {
                                                  return ClipRRect(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      placeholder: (context, url) => Center(
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
                                                duration: 400,
                                                autoplayDelay: 4000,
                                              )
                                            : Center(
                                                child: Text('暂无图片展示'),
                                              ),
                                      ),
                                      flex: 5,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.white70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(25),
                                                right: ScreenUtil().setWidth(25),
                                              ),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.deepOrangeAccent),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  color: Colors.deepOrangeAccent,
                                                ),
                                                child: Padding(
                                                  child: Text(
                                                    "资\n讯",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: ScreenUtil().setHeight(3),
                                                    horizontal: ScreenUtil().setWidth(12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  right: ScreenUtil().setWidth(31),
                                                ),
                                                child: Swiper(
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: canShowHeadLine
                                                              ? Text(
                                                                  _showNewsList[index].title,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    fontSize: ScreenUtil().setSp(44),
                                                                  ),
                                                                )
                                                              : Text('暂无资讯信息'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: _showNewsList.length > 0 ? _showNewsList.length : 1,
                                                  autoplay: _showNewsList.length > 1,
                                                  duration: 600,
                                                  autoplayDelay: 6000,
                                                  onTap: (int index) {
                                                    // 进入资讯详情
                                                    if (_showNewsList.length > 0) {
                                                      final Headline headLine = _showNewsList[index];
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (BuildContext context) {
                                                            return InformationDetail(
                                                              headLine: headLine,
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      print('没有资讯信息，不响应点击事件');
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
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
                      // 菜单项
                      SliverPadding(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: ScreenUtil().setWidth(30),
                            crossAxisSpacing: ScreenUtil().setWidth(30),
                            childAspectRatio: 1.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return InkWell(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(180),
                                        height: ScreenUtil().setHeight(180),
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
                                        padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(0),
                                          ScreenUtil().setHeight(25),
                                          ScreenUtil().setWidth(0),
                                          ScreenUtil().setHeight(0),
                                        ),
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
                                onTap: menuEntityList[index].function,
                              );
                            },
                            childCount: menuEntityList.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
          // return null; // unreachable
          return reTryWidget();
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
  Function function;

  MenuEntity(this.color, this.icon, this.menuText, this.function);
}
