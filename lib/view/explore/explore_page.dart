import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: PageStorageKey(_ExplorePageState),
      appBar: AppBar(
        title: Text(S.of(context).Explore),
        centerTitle: true,
      ),
      body: Center(
        child: Text(S.of(context).Explore),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
