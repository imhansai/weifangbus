import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:weifangbus/view/explore/explore_page.dart';
import 'package:weifangbus/view/home/home_page.dart';
import 'package:weifangbus/view/more/more_page.dart';

/// 主页
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  /// 方便展示提示信息
  final _homeKey = GlobalKey<ScaffoldState>();

  /// 主要操作页面
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
    return Scaffold(
      key: _homeKey,
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
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: AppLocalizations.of(context)!.explore,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: AppLocalizations.of(context)!.more,
          ),
        ],
      ),
    );
  }
}
