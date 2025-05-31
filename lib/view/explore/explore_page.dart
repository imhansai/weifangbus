import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context)!.explore),
        centerTitle: true,
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.explore),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
