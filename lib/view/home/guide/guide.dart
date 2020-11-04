import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Guide),
      ),
      body: Container(
        child: Center(
          child: Text(S.of(context).Guide),
        ),
      ),
    );
  }
}
