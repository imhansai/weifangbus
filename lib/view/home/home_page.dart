import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/menu_entity.dart';
import 'package:weifangbus/entity/new_info_summary_entity.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/view/home/guide/guide.dart';
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

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  /// 所有线路
  List<MaterialSearchResult<String>> _allRouteList = List.empty(growable: true);

  /// 资讯信息列表(状态变更用)
  late NewsModel _showNewsList;

  /// 是否展示轮播图
  var _canShowSlideShow = true;

  /// 是否展示资讯信息
  var _canShowHeadLine = true;

  @override
  void initState() {
    super.initState();
    _getAllRoute();
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

  /// 请求所有的路线
  _getAllRoute() async {
    Response response;
    var uri = "/Query_AllRouteData/?" + getSignString();
    response = await dio.get(uri);
    AllRouteDataEntity allRouteDataEntity = AllRouteDataEntity.fromJson(response.data);
    print("请求 线路信息 完毕");
    var routeList = allRouteDataEntity.routeList;
    List<MaterialSearchResult<String>> materialSearchResultList = List.empty(growable: true);
    for (var i = 0; i < routeList!.length; ++i) {
      var route = routeList[i];
      var materialSearchResult = MaterialSearchResult<String>(
        index: i,
        value: route.routeName!,
        icon: Icons.directions_bus,
        routeName: route.routeName!,
        routeNameExt: route.routeName!,
        onTap: () {},
      );
      materialSearchResultList.add(materialSearchResult);
    }
    setState(() {
      _allRouteList = materialSearchResultList;
    });
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
                          maxLines: 2,
                        ),
                        quarterTurns: 4,
                      ),
                padding: EdgeInsets.all(
                  12,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 25),
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
                                      fontSize: 20,
                                    ),
                                  )
                                : Text(AppLocalizations.of(context)!.noNews),
                          ),
                        ],
                      ),
                      onTap: () {
                        // 进入资讯详情
                        if (_showNewsList.showNewsList.length > 0) {
                          final NewInfoSummaryEntity headLine = i;
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
              items: List.empty().map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => CircularProgressIndicator(),
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
      padding: EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return InkWell(
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 2,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        menuEntityList[index].menuText,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
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
      body: contentWidget(),
    );
  }
}
