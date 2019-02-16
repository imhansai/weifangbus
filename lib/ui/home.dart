import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/generated/translations.dart';
import 'package:weifangbus/ui/explore/explore_page.dart';
import 'package:weifangbus/ui/home/home_page.dart';
import 'package:weifangbus/ui/more/more_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = <Widget>[
    HomePage(),
    ExplorePage(),
    MorePage(),
  ];

  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920, allowFontScaling: true)..init(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: myTabs.map((Widget widget) {
          return widget;
        }).toList(),
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              Translations.of(context).text('home'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text(
              Translations.of(context).text('explore'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            title: Text(
              Translations.of(context).text('more'),
            ),
          ),
        ],
      ),
    );
  }
}
