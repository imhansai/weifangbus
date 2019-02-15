import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/generated/translations.dart';
import 'package:weifangbus/ui/home/home_page.dart';
import 'package:weifangbus/ui/more/more.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = <Widget>[
    HomePage(),
    MorePage(),
  ];

  // 页面控制
  TabController _tabController;

  // 底部栏切换
  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: myTabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920, allowFontScaling: true)..init(context);
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Widget widget) {
          return widget;
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text(Translations.of(context).text('home')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            title: Text(Translations.of(context).text('more')),
          ),
        ],
      ),
    );
  }
}
