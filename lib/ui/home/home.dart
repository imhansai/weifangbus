import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/ui/home/news_list.dart';
import 'package:weifangbus/ui/home/loopPicAndNews.dart';
import 'package:weifangbus/utils/fontUtil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<MenuEntity> menuEntityList = new List();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('首页'),
      ),
      body: new Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(0)),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return new Container(
                      height: ScreenUtil().setHeight(621),
                      child: LoopPicAndInformation(),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
              sliver: new SliverGrid(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: ScreenUtil().setWidth(10),
                  crossAxisSpacing: ScreenUtil().setWidth(10),
                  childAspectRatio: 1.0,
                ),
                delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new Center(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: ScreenUtil().setWidth(170),
                              height: ScreenUtil().setHeight(170),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: menuEntityList[index].color,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(ScreenUtil().setWidth(2), ScreenUtil().setWidth(2)),
                                        blurRadius: 4.0),
                                  ],
                                ),
                                child: new Center(
                                  child: Icon(
                                    menuEntityList[index].icon,
                                    size: ScreenUtil().setWidth(80),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            new Padding(
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    MenuEntity lineInquiry = new MenuEntity(Colors.lightBlue, MyIcons.lineInquiry, '线路查询', null);
    menuEntityList.add(lineInquiry);
    MenuEntity guide = new MenuEntity(Colors.lightGreen, MyIcons.guide, '导乘', null);
    menuEntityList.add(guide);
    MenuEntity news = new MenuEntity(Colors.orangeAccent, MyIcons.news, '资讯', NewsListPage());
    menuEntityList.add(news);
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
