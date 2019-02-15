import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('更多'),
      ),
      body: Container(
        child: Center(
          child: Text('未完待续'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
