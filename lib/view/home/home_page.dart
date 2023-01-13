import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/menu_entity.dart';
import 'package:weifangbus/entity/start_up_basic_info_entity.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/view/home/guide/guide.dart';
import 'package:weifangbus/view/home/news/news_detail.dart';
import 'package:weifangbus/view/home/news/news_list.dart';
import 'package:weifangbus/view/home/searchbar/search_bar.dart';
import 'package:weifangbus/view/home/searchbar/search_input.dart';
import 'package:weifangbus/view/store/news_model.dart';

import '../../entity/head_line_entity.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  /// 初始页json数据实体类
  late Future<StartUpBasicInfoEntity> _startUpBasicInfoFuture;

  /// 所有线路
  List<MaterialSearchResult<String>> _allRouteList = List.empty(growable: true);

  /// [_startUpBasicInfoFuture] 请求成功后的数据
  late StartUpBasicInfoEntity _startUpBasicInfoEntity;

  /// 资讯信息列表(状态变更用)
  late NewsModel _showNewsList;

  /// 是否展示轮播图
  var _canShowSlideShow = false;

  /// 是否展示资讯信息
  var _canShowHeadLine = false;

  @override
  void initState() {
    super.initState();
    _startUpBasicInfoFuture = _getStartUpBasicInfoFuture();
  }

  @override
  bool get wantKeepAlive => true;

  /// 展示 SnackBar
  void showSnackBar(String snackStr) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  /// 设置菜单
  setMenuEntityList() {
    List<MenuEntity> menuEntityList = List.empty(growable: true);
    MenuEntity lineInquiry = MenuEntity(
      Colors.lightGreen,
      MyIcons.lineInquiry,
      AppLocalizations.of(context)!.routeQuery,
      () {
        Navigator.push(
          context,
          MaterialPageRoute<String>(
            builder: (BuildContext context) {
              return Material(
                child: MaterialSearch<String>(
                  barBackgroundColor: Theme.of(context).primaryColor,
                  placeholder: AppLocalizations.of(context)!.searchLine,
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
      AppLocalizations.of(context)!.guide,
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
      AppLocalizations.of(context)!.news,
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
            StartUpBasicInfoEntity.fromJson(response.data);
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
    AllRouteDataEntity allRouteDataEntity =
        AllRouteDataEntity.fromJson(response.data);
    print("请求 线路信息 完毕");
    var routeList = allRouteDataEntity.RouteList;
    List<MaterialSearchResult<String>> materialSearchResultList =
        List.empty(growable: true);
    for (var i = 0; i < routeList!.length; ++i) {
      var route = routeList[i];
      var materialSearchResult = MaterialSearchResult<String>(
        index: i,
        value: route.routename,
        // icon: Icons.directions_bus,
        routeName: route.routename,
        routeNameExt: route.routenameext.substring(
            route.routenameext.indexOf('(') + 1, route.routenameext.length - 1),
        onTap: () {},
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
      child: ElevatedButton(
        child: AutoSizeText(
          AppLocalizations.of(context)!.requestDataFailure,
          maxLines: 2,
        ),
        onPressed: reTry,
      ),
    );
  }

  /// 等待状态展示等待动画
  Widget waitingWidget() {
    return Text('Awaiting result...');
  }

  /// 轮播图 + 资讯
  Widget swiperAndInfoWidget() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: 435, // 435 + 174
            child: slideShowWidget(),
          ),
          Container(
            height: 174, // 435 + 174
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
              left: 25,
              right: 25,
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
                        AppLocalizations.of(context)!.homeNews,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : RotatedBox(
                        child: AutoSizeText(
                          AppLocalizations.of(context)!.homeNews,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                        quarterTurns: 3,
                      ),
                padding: EdgeInsets.all(
                  12,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 31),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                ),
                items: _showNewsList.showNewsList.map((i) {
                  return Builder(builder: (context) {
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: _canShowHeadLine
                                ? Text(
                                    i.Title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 44,
                                    ),
                                  )
                                : Text(AppLocalizations.of(context)!.noNews),
                          ),
                        ],
                      ),
                      onTap: () {
                        // 进入资讯详情
                        if (_showNewsList.showNewsList.length > 0) {
                          final HeadLineEntity headLine = i;
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
                    );
                  });
                }).toList(),
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
        top: 30,
        bottom: 30,
      ),
      child: _canShowSlideShow
          ? CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
              ),
              items: _startUpBasicInfoEntity.SlideShow!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl: i.bannerurl,
                        fadeInCurve: Curves.easeIn,
                        fadeInDuration: Duration(seconds: 1),
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            )
          : Center(
              child: Text(AppLocalizations.of(context)!.noPictures),
            ),
    );
  }

  /// 菜单项
  Widget menuWidget() {
    /// 菜单项
    List<MenuEntity> menuEntityList = setMenuEntityList();
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
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
                      width: 180,
                      height: 180,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: menuEntityList[index].color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(
                                  2,
                                  2,
                                ),
                                blurRadius: 4.0),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            menuEntityList[index].icon,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 25,
                      ),
                      child: Text(
                        menuEntityList[index].menuText,
                        style: TextStyle(
                          fontSize: 40,
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
    _canShowSlideShow = _startUpBasicInfoEntity.SlideShow!.length > 0;
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
                _startUpBasicInfoEntity = snapshot.data!;
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
