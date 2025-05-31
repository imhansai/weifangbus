import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.guide),
      ),
      body: Container(
        child: Center(
          child: Text(AppLocalizations.of(context)!.guide),
        ),
      ),
    );
  }
}
