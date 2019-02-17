import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              expandedHeight: ScreenUtil().setHeight(399),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/more_page.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new SliverFixedExtentList(
              itemExtent: 80.0,
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建列表项
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: new Text('list item $index'),
                  );
                },
                childCount: 5, //50个列表项
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
