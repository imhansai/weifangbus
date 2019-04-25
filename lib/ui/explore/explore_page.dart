import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/services.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin {
  // 扫描结果
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: PageStorageKey(_ExplorePageState),
      appBar: AppBar(
        title: Text("发现"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Ionicons.getIconData("md-qr-scanner"),
            ),
            tooltip: '扫一扫',
            onPressed: scan,
          ),
        ],
      ),
      body: Center(
        // 展示扫描结果
        child: Text(barcode),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  // 响应扫描事件
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          // 用户未授权
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        // 未知错误
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      // 在扫描出结果之前按了返回
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      // 未知错误
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
