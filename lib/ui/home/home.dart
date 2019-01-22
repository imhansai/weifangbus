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
              sliver: new SliverGrid(
                //Grid
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.0,
                ),
                delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: new Text('功能 $index'),
                      ),
                      onTap: () {
                        print('功能 $index');
                      },
                    );
                  },
                  childCount: 4,
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
}
