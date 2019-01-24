import 'package:flutter/material.dart';
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
              padding: EdgeInsets.all(0),
              sliver: SliverFixedExtentList(
                itemExtent: 230.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return new Container(
                      child: LoopPicAndInformation(),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: new SliverGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 1.0,
                children: <Widget>[
                  new GestureDetector(
                    child: new Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0),
                                ],
                              ),
                              child: new Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  MyIcons.lineInquiry,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            width: 64,
                            height: 64,
                          ),
                          new Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '线路查询',
                              style: TextStyle(
                                fontSize: 16,
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
                            width: 64,
                            height: 64,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  MyIcons.guide,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '导乘',
                              style: TextStyle(
                                fontSize: 16,
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
                            width: 64,
                            height: 64,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  MyIcons.news,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '资讯',
                              style: TextStyle(
                                fontSize: 16,
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
