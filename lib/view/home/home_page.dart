import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/headline_entity.dart';
import 'package:weifangbus/entity/menu_entity.dart';
import 'package:weifangbus/entity/startup_basic_info_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/view/home/guide/guide.dart';
import 'package:weifangbus/view/home/line/route_detail.dart';
import 'package:weifangbus/view/home/news/news_detail.dart';
import 'package:weifangbus/view/home/news/news_list.dart';
import 'package:weifangbus/view/home/searchbar/search_bar.dart';
import 'package:weifangbus/view/home/searchbar/search_input.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  /// 初始页json数据实体类
  Future<StartUpBasicInfoEntity> _startUpBasicInfoFuture;

  /// 所有线路
  List<MaterialSearchResult<String>> _allRouteList = List();

  /// [_startUpBasicInfoFuture] 请求成功后的数据
  StartUpBasicInfoEntity _startUpBasicInfoEntity;

  /// 资讯信息列表(状态变更用)
  NewsModel _showNewsList;

  /// 是否展示轮播图
  var _canShowSlideShow = false;

  /// 是否展示资讯信息
  var _canShowHeadLine = false;

  /// 屏幕方向
  Orientation _orientation;

  @override
  void initState() {
    super.initState();
    _startUpBasicInfoFuture = _getStartUpBasicInfoFuture();
  }

  @override
  bool get wantKeepAlive => true;

  /// 展示 SnackBar
  void showSnackBar(String snackStr) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  /// 设置菜单
  setMenuEntityList() {
    List<MenuEntity> menuEntityList = List();
    MenuEntity lineInquiry = MenuEntity(
      Colors.lightGreen,
      MyIcons.lineInquiry,
      S.of(context).RouteQuery,
      () {
        Navigator.push(
          context,
          MaterialPageRoute<String>(
            builder: (BuildContext context) {
              return Material(
                child: MaterialSearch<String>(
                  barBackgroundColor: Theme.of(context).primaryColor,
                  placeholder: S.of(context).SearchLine,
                  results: _allRouteList,
                  filter: (dynamic value, String criteria) {
                    return value.toLowerCase().trim().contains(
                        RegExp(r'' + criteria.toLowerCase().trim() + ''));
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
      S.of(context).Guide,
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
      S.of(context).News,
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsListPage();
            },
          ),
        );
      },
    );
    menuEntityList.add(news);
    return menuEntityList;
  }

  /// 请求首页数据
  Future<StartUpBasicInfoEntity> _getStartUpBasicInfoFuture() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // todo 应该作用线路搜索页上
        _getAllRoute();
        var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
        Response response = await dio.get(uri);
        var startUpBasicInfoEntity =
            EntityFactory.generateOBJ<StartUpBasicInfoEntity>(response.data);
        print("请求 轮播图 完毕");
        if (startUpBasicInfoEntity == null) {
          startUpBasicInfoEntity = StartUpBasicInfoEntity();
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

  /// 请求所有的路线
  _getAllRoute() async {
    Response response;
    var uri = "/BusService/Require_AllRouteData/?" + getSignString();
    // print('$uri');
    response = await dio.get(uri);
    AllroutedataEntity allRouteDataEntity =
        EntityFactory.generateOBJ<AllroutedataEntity>(response.data);
    print("请求 线路信息 完毕");
    var routeList = allRouteDataEntity.routelist;
    List<MaterialSearchResult<String>> materialSearchResultList = List();
    for (var i = 0; i < routeList.length; ++i) {
      var route = routeList[i];
      var materialSearchResult = MaterialSearchResult<String>(
        index: i,
        value: route.routename,
        // icon: Icons.directions_bus,
        routeName: route.routename,
        routeNameExt: route.routenameext.substring(
            route.routenameext.indexOf('(') + 1, route.routenameext.length - 1),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return RouteDetail(
                  title: route.routenameext
                      .substring(0, route.routenameext.indexOf('(')),
                  routeId: route.routeid,
                );
              },
            ),
          );
        },
      );
      materialSearchResultList.add(materialSearchResult);
    }
    setState(() {
      _allRouteList = materialSearchResultList;
    });
  }

  /// 重试处理
  reTry() {
    setState(() {
      _startUpBasicInfoFuture = _getStartUpBasicInfoFuture();
      if (_showNewsList == null) {
        Future.microtask(() => context.read<NewsModel>().refreshNewsList());
      }
      // getAllRoute();
    });
  }

  /// 出现错误展示的控件
  Widget reTryWidget() {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        highlightColor: Colors.blue[700],
        colorBrightness: Brightness.dark,
        splashColor: Colors.grey,
        child: AutoSizeText(
          S.of(context).RequestDataFailure,
          maxLines: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: reTry,
      ),
    );
  }

  /// 等待状态展示等待动画
  Widget waitingWidget() {
    // return Text('Awaiting result...');
    return SpinKitWave(
      color: Colors.blue,
      type: SpinKitWaveType.center,
    );
  }

  /// 轮播图 + 资讯
  Widget swiperAndInfoWidget() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: _orientation == Orientation.portrait
                ? 435.h
                : 870.h, // 435 + 174
            child: slideShowWidget(),
          ),
          Container(
            height: _orientation == Orientation.portrait
                ? 174.h
                : 348.h, // 435 + 174
            child: infoShowWidget(),
          ),
        ],
      ),
    );
  }

  /// 资讯信息
  Widget infoShowWidget() {
    var currentLocale = Intl.getCurrentLocale();
    // print('current locale: $currentLocale');
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: _orientation == Orientation.portrait ? 25.w : 12.w,
              right: _orientation == Orientation.portrait ? 25.w : 12.w,
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
                child: currentLocale == 'zh'
                    ? AutoSizeText(
                        S.of(context).HomeNews,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : RotatedBox(
                        child: AutoSizeText(
                          S.of(context).HomeNews,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                        quarterTurns: 3,
                      ),
                padding: EdgeInsets.all(
                  _orientation == Orientation.portrait ? 12.w : 6.w,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: _orientation == Orientation.portrait ? 31.w : 15.w,
              ),
              child: Swiper(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _canShowHeadLine
                            ? Text(
                                _showNewsList.showNewsList[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: _orientation == Orientation.portrait
                                      ? 44.ssp
                                      : 22.ssp,
                                ),
                              )
                            : Text(S.of(context).NoNews),
                      ),
                    ],
                  );
                },
                scrollDirection: Axis.vertical,
                itemCount: _showNewsList.showNewsList.length > 0
                    ? _showNewsList.showNewsList.length
                    : 1,
                autoplay: _showNewsList.showNewsList.length > 1,
                duration: 600,
                autoplayDelay: 6000,
                onTap: (int index) {
                  // 进入资讯详情
                  if (_showNewsList.showNewsList.length > 0) {
                    final Headline headLine = _showNewsList.showNewsList[index];
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
    );
  }

  /// 轮播图
  Widget slideShowWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: _orientation == Orientation.portrait ? 30.h : 60.h,
        bottom: _orientation == Orientation.portrait ? 30.h : 60.h,
      ),
      child: _canShowSlideShow
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
                        size:
                            _orientation == Orientation.portrait ? 80.w : 40.w,
                      ),
                    ),
                    imageUrl:
                        _startUpBasicInfoEntity.slideshow[index].bannerurl,
                    fadeInCurve: Curves.easeIn,
                    fadeInDuration: Duration(seconds: 1),
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: _startUpBasicInfoEntity.slideshow.length,
              viewportFraction: 0.9,
              scale: 0.95,
              autoplay: true,
              duration: 400,
              autoplayDelay: 4000,
            )
          : Center(
              child: Text(S.of(context).NoPictures),
            ),
    );
  }

  /// 菜单项
  Widget menuWidget() {
    /// 菜单项
    List<MenuEntity> menuEntityList = setMenuEntityList();
    return SliverPadding(
      padding:
          EdgeInsets.all(_orientation == Orientation.portrait ? 10.w : 5.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _orientation == Orientation.portrait ? 3 : 6,
          mainAxisSpacing: _orientation == Orientation.portrait ? 30.w : 60.w,
          crossAxisSpacing: _orientation == Orientation.portrait ? 60.w : 30.w,
          childAspectRatio: _orientation == Orientation.portrait ? 1.0 : 1.0,
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
                      width:
                          _orientation == Orientation.portrait ? 180.w : 90.w,
                      height:
                          _orientation == Orientation.portrait ? 180.h : 360.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: menuEntityList[index].color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(
                                  2.w,
                                  2.w,
                                ),
                                blurRadius: 4.0),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            menuEntityList[index].icon,
                            size: _orientation == Orientation.portrait
                                ? 80.w
                                : 40.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: _orientation == Orientation.portrait ? 25.h : 50.h,
                      ),
                      child: Text(
                        menuEntityList[index].menuText,
                        style: TextStyle(
                          fontSize: _orientation == Orientation.portrait
                              ? 40.ssp
                              : 20.ssp,
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
    );
  }

  /// 页面内容展示
  Widget contentWidget() {
    _canShowSlideShow = _startUpBasicInfoEntity.slideshow.length > 0;
    _canShowHeadLine = _showNewsList.showNewsList.length > 0;
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          swiperAndInfoWidget(),
          menuWidget(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _orientation = MediaQuery.of(context).orientation;

    // 随着资讯信息的变化而变化
    _showNewsList = context.watch<NewsModel>();
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(allRouteList: _allRouteList),
      ),
      body: FutureBuilder<StartUpBasicInfoEntity>(
        future: _startUpBasicInfoFuture,
        builder: (BuildContext context,
            AsyncSnapshot<StartUpBasicInfoEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return waitingWidget();
            case ConnectionState.done:
              if (snapshot.hasError) {
                // return Text('Error: ${snapshot.error}');
                return reTryWidget();
              }
              // return Text('Result: ${snapshot.data}');
              if (snapshot.hasData) {
                _startUpBasicInfoEntity = snapshot.data;
                return contentWidget();
              }
          }
          // return null; // unreachable
          return reTryWidget();
        },
      ),
    );
  }
}
