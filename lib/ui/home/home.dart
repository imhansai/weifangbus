import 'package:flutter/material.dart';
import 'package:weifangbus/ui/home/loopPicAndInformation.dart';

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
                  new Container(
                    child: new GestureDetector(
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: new Text('功能 1'),
                      ),
                      onTap: () {
                        print('功能 1');
                      },
                    ),
                  ),
                  new Container(
                    child: new GestureDetector(
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: new Text('功能 2'),
                      ),
                      onTap: () {
                        print('功能 2');
                      },
                    ),
                  ),
                  new Container(
                    child: new GestureDetector(
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: new Text('功能 3'),
                      ),
                      onTap: () {
                        print('功能 3');
                      },
                    ),
                  ),
                  new Container(
                    child: new GestureDetector(
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: new Text('功能 4'),
                      ),
                      onTap: () {
                        print('功能 4');
                      },
                    ),
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
