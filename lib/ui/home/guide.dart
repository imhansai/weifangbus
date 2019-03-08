import 'package:flutter/material.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("导乘"),
      ),
      body: Container(
        child: Center(
          child: Text("导乘"),
        ),
      ),
    );
  }
}
