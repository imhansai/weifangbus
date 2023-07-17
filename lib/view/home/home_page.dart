import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/menu_entity.dart';
import 'package:weifangbus/entity/new_info_summary_entity.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/view/home/line/RouteDetail.dart';
import 'package:weifangbus/view/home/news/news_detail.dart';
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

  List<Image> _banners = [
    // Image.asset('assets/images/home/ad.png'),
    Image.asset('assets/images/home/banner.png'),
  ];

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
      color: Colors.lightGreen,
      icon: MyIcons.lineInquiry,
      menuText: AppLocalizations.of(context)!.routeQuery,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<String>(
            builder: (BuildContext context) {
              return MaterialSearch<String>(
                barBackgroundColor: Theme.of(context).primaryColor,
                placeholder: AppLocalizations.of(context)!.searchLine,
                results: _allRouteList,
                filter: (dynamic value, String criteria) {
                  return value.toLowerCase().trim().contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                },
              );
            },
          ),
        );
      },
    );
    menuEntityList.add(lineInquiry);
    MenuEntity guide = MenuEntity(
      color: Colors.lightBlue,
      icon: MyIcons.guide,
      menuText: AppLocalizations.of(context)!.guide,
      onTap: () {
        Navigator.pushNamed(context, '/guide');
      },
    );
    menuEntityList.add(guide);
    MenuEntity news = MenuEntity(
      color: Colors.orangeAccent,
      icon: MyIcons.news,
      menuText: AppLocalizations.of(context)!.news,
      onTap: () {
        Navigator.pushNamed(context, '/newsList');
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return RouteDetail(
                  title: route.routeName,
                  routeId: route.routeID,
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

  /// 轮播图 + 资讯
  Widget swiperAndInfoWidget() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: 200,
            child: slideShowWidget(),
          ),
          Container(
            height: 60,
            child: infoShowWidget(),
          ),
        ],
      ),
    );
  }

  /// 资讯信息
  Widget infoShowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrangeAccent),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.deepOrangeAccent,
            ),
            child: Padding(
              child: AutoSizeText(
                AppLocalizations.of(context)!.homeNews,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1.0,
              ),
              items: _showNewsList.showNewsList.map((i) {
                return Builder(builder: (context) {
                  return GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              i.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
    );
  }

  /// 轮播图
  Widget slideShowWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
        ),
        items: _banners.map((banner) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: banner,
              );
            },
          );
        }).toList(),
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
              onTap: menuEntityList[index].onTap,
            );
          },
          childCount: menuEntityList.length,
        ),
      ),
    );
  }

  /// 页面内容展示
  Widget contentWidget() {
    return CustomScrollView(
      slivers: <Widget>[
        swiperAndInfoWidget(),
        menuWidget(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 随着资讯信息的变化而变化
    _showNewsList = context.watch<NewsModel>();
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: LineSearchBar(allRouteList: _allRouteList),
      ),
      body: contentWidget(),
    );
  }
}
