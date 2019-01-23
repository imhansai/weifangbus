import 'package:flutter/material.dart';
import 'package:weifangbus/ui/home/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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
    _tabController = new TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Home(),
          new Center(
            child: new Text('敬请期待!!!'),
          ),
          new Center(
            child: new Text('敬请期待!!!'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text('发现')),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert), title: Text('更多'))
        ],
      ),
    );
  }
}
