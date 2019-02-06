import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weifangbus/entity/home/allRouteData_entity.dart';
import 'package:weifangbus/entity/home/startUpBasicInfo_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/ui/home/news_detail.dart';
import 'package:weifangbus/ui/home/news_list.dart';
import 'package:weifangbus/ui/home/search_demo.dart';
import 'package:weifangbus/ui/home/search_input.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/fontUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

/// 首页
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  // 菜单项
  List<MenuEntity> menuEntityList;

  // 初始页json数据实体类
  Future<StartUpBasicInfoEntity> _startUpBasicInfoEntity;

  // 资讯列表
  List<Headline> _showNewsList;

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
        /*action: SnackBarAction(
          label: '重试',
          onPressed: () {
            reTry();
          },
        ),*/
      ),
    );
  }

  // 请求首页数据
  Future<StartUpBasicInfoEntity> getStartUpBasicInfoEntity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
        Response response = await dio.get(uri);
        var startUpBasicInfoEntity = EntityFactory.generateOBJ<StartUpBasicInfoEntity>(response.data);
        _showNewsList = startUpBasicInfoEntity.headline;
        print("请求首页数据完毕");
        // 测试用
        // StartUpBasicInfoEntity startUpBasicInfoEntity = StartUpBasicInfoEntity();
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    menuEntityList = List();
    MenuEntity lineInquiry = MenuEntity(Colors.lightGreen, MyIcons.lineInquiry, '线路查询');
    menuEntityList.add(lineInquiry);
    MenuEntity guide = MenuEntity(Colors.lightBlue, MyIcons.guide, '导乘');
    menuEntityList.add(guide);
    MenuEntity news = MenuEntity(Colors.orangeAccent, MyIcons.news, '资讯');
    menuEntityList.add(news);
    _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
  }

  // 重试处理
  reTry() {
    setState(() {
      _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
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

  // 供选择的条目
  final _names = [
    'Igor Minar',
    'Brad Green',
    'Dave Geddes',
    'Naomi Black',
    'Greg Weber',
    'Dean Sofer',
    'Wes Alvaro',
    'John Scott',
    'Daniel Nadasi',
  ];

  Future<List<Routelist>> getAllRoute() async {
    try {
      Response response;
      var uri = "/BusService/Require_AllRouteData/?" + getSignString();
      response = await dio.get(uri);
      AllroutedataEntity allRouteDataEntity = EntityFactory.generateOBJ<AllroutedataEntity>(response.data);
      print('请求所有线路完毕');
      return allRouteDataEntity.routelist;
    } catch (e) {
      print('请求出现问题::: $e');
      return Future.value(null);
    }
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
                placeholder: '搜索线路',
                getResults: (value) async {
                  if (value != '') {
                    var routeList = await getAllRoute();
                    return routeList
                        .map((item) => MaterialSearchResult<String>(
                              value: item.routename,
                              icon: Icons.directions_bus,
                              text: item.routenameext,
                              onTap: () {
                                print(item.routename);
                              },
                            ))
                        .toList();
                  } else {
                    return null;
                  }
                },
                filter: (dynamic value, String criteria) {
                  return value.toLowerCase().trim().contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                },
                onSelect: (dynamic v) {
                  print(v);
                },
                validator: (dynamic value) => value == null ? 'Required field' : null,
                formatter: (dynamic v) => 'Hello, $v',
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
      body: FutureBuilder(
        future: _startUpBasicInfoEntity,
        builder: (context, result) {
          // 加载中.展示加载动画
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

          // 加载完成
          if (result.connectionState == ConnectionState.done) {
            if (result.hasData) {
              var startUpBasicInfoEntity = result.data as StartUpBasicInfoEntity;
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
                                                  child: Padding(
                                                    child: Text(
                                                      '资讯',
                                                      style: TextStyle(
                                                        color: Colors.deepOrangeAccent,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: ScreenUtil().setHeight(3),
                                                      horizontal: ScreenUtil().setWidth(12),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                      ScreenUtil().setWidth(12),
                                                    ),
                                                    child: canShowHeadLine
                                                        ? Text(
                                                            _showNewsList[index].title,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          )
                                                        : Text('暂无资讯信息'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          scrollDirection: Axis.vertical,
                                          itemCount: _showNewsList.length > 0 ? _showNewsList.length : 1,
                                          autoplay: _showNewsList.length > 1,
                                          duration: 300,
                                          autoplayDelay: 3000,
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
                              onTap: () {
                                if (menuEntityList[index].menuText == '线路查询') {
                                  print('准备进入线路查询');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<String>(
                                      settings: RouteSettings(
                                        name: 'material_search',
                                        isInitialRoute: false,
                                      ),
                                      builder: (BuildContext context) {
                                        return Material(
                                          child: MaterialSearch<String>(
                                            barBackgroundColor: Theme.of(context).primaryColor,
                                            placeholder: '搜索线路',
                                            results: _names
                                                .map((String v) => MaterialSearchResult<String>(
                                                      icon: Icons.person,
                                                      value: v,
                                                      text: "Mr(s). $v",
                                                      onTap: () {
                                                        print('$v');
                                                      },
                                                    ))
                                                .toList(),
                                            filter: (dynamic value, String criteria) {
                                              return value
                                                  .toLowerCase()
                                                  .trim()
                                                  .contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                                            },
                                            onSelect: (dynamic value) => Navigator.of(context).pop(value),
                                            onSubmit: (String value) {
                                              // 输入法点击完成后的回调函数
                                              print(value);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                // 进入导乘页面
                                if (menuEntityList[index].menuText == '导乘') {
                                  print('准备进入导乘');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SearchDemo(
                                          title: "搜索示例",
                                        );
                                      },
                                    ),
                                  );
                                }
                                // 进入资讯列表
                                if (menuEntityList[index].menuText == '资讯') {
                                  print('准备进入资讯');
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
            } else {
              // 出现错误,重试机制
              return reTryWidget();
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

  MenuEntity(this.color, this.icon, this.menuText);
}
