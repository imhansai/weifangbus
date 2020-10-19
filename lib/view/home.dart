import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: '发现',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              label: '更多',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  /// 最近一次点击时间
  DateTime _lastTime;

  /// 再点一次退出程序
  Future<bool> _onWillPop() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(milliseconds: 1500)) {
      print('准备退出');
      _lastTime = DateTime.now();
      _homeKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            '再次点击退出应用',
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 1500),
        ),
      );
      return Future.value(false);
    }
    print('退出了鸭,ByeBye');
    return Future.value(true);
  }
}
