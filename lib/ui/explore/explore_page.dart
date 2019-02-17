import 'package:flutter/material.dart';
import 'package:weifangbus/generated/translations.dart';

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
        title: Text(Translations.of(context).text('explore')),
      ),
      body: Center(
        child: Text(Translations.of(context).text('explore')),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
