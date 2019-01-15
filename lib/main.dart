import 'package:flutter/material.dart';

void main() => runApp(WeiFangBusApp());

class WeiFangBusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '潍坊公交',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _widgetOptions = [
    Text('这是首页'),
    Text('这是导乘'),
    Text('这是更多'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("欢迎使用潍坊公交"),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: '目录',
          ),
          onPressed: () {
            print('目录按钮');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: '搜索',
            ),
            onPressed: () {
              print('搜索按钮');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: '过滤',
            ),
            onPressed: () {
              print('过滤按钮');
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), title: Text('导乘')),
          BottomNavigationBarItem(icon: Icon(Icons.center_focus_weak), title: Text('更多')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
