import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/ui/home/loopPicAndInformation.dart';
import 'package:weifangbus/utils/fontUtil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
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
              sliver: new SliverGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: ScreenUtil().setWidth(10),
                crossAxisSpacing: ScreenUtil().setWidth(10),
                childAspectRatio: 1.0,
                children: <Widget>[
                  new GestureDetector(
                    child: new Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            width: ScreenUtil().setWidth(180),
                            height: ScreenUtil().setHeight(180),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
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
                                  MyIcons.lineInquiry,
                                  size: ScreenUtil().setWidth(90),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                            child: Text(
                              '线路查询',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('线路查询');
                    },
                  ),
                  new GestureDetector(
                    child: new Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            width: ScreenUtil().setWidth(180),
                            height: ScreenUtil().setHeight(180),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(ScreenUtil().setWidth(2), ScreenUtil().setWidth(2)),
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                              child: new Center(
                                child: Icon(
                                  MyIcons.guide,
                                  color: Colors.white,
                                  size: ScreenUtil().setWidth(90),
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                            child: Text(
                              '导乘',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('导乘');
                    },
                  ),
                  new GestureDetector(
                    child: new Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            width: ScreenUtil().setWidth(180),
                            height: ScreenUtil().setHeight(180),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(ScreenUtil().setWidth(2), ScreenUtil().setWidth(2)),
                                    blurRadius: 4.0,
                                  ),
                                ],
                              ),
                              child: new Center(
                                child: Icon(
                                  MyIcons.news,
                                  color: Colors.white,
                                  size: ScreenUtil().setWidth(90),
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                            child: Text(
                              '资讯',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('资讯');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
