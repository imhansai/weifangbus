import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: PageStorageKey(_ExplorePageState),
      appBar: AppBar(
        title: Text("发现"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("探索"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
