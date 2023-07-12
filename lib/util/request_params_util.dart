import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:weifangbus/util/dio_util.dart';

Future main() async {
  try {
    Response response;
    var routeId = encryptedString("17");
    var segmentid = encryptedString("35505665");
    var stationID = encryptedString("55160715165306818201");
    var uri = '/QueryDetail_ByRouteID?RouteID=$routeId&Segmentid=$segmentid&${getSignString()}';
    // [{"bannerid":"30200402152455397000","name":"掌上公交2.0启动图","title":null,"bannerurl":"http://122.4.254.30:3010/InfoIsland/App/banner管理_200619163050_11200619163050069301.png","linkurl":null,"bannerusefor":"4"}]
    print(uri);
    response = await dio.get(uri);
    print(response.data);
  } catch (e) {
    print('请求出现问题::: $e');
  }
}

/// 获取时间戳
getTimeStamp() =>
    DateFormat("yyyyMMddHHmmss").format(DateTime.now()).toString();

/// 获取随机数
getRandom() => (100 + Random().nextInt(900)).toString();

/// 生成签名密钥
getSignKey(timeStamp, random) {
  // 59485eebe12042cba33e972f77834b6b 聊城
  // 55b73c446e914785862966abf9a29416 潍坊
  // adf0d9607ab24a3d88a5fb5413813e2a 潍坊新版本
  final appKey = "adf0d9607ab24a3d88a5fb5413813e2a";
  var key = utf8.encode(appKey);
  var bytes = utf8.encode(timeStamp + random);

  // HMAC-SHA256
  var hmacSha256 = Hmac(sha256, key);
  var digest = hmacSha256.convert(bytes);

  // print("HMAC digest as bytes: ${digest.bytes}");
  // print("HMAC digest as hex string: $digest");

  return digest.toString();
}

getPackageName() {
  return "com.hisense.wfbus2";
}

/// 获取参数
getSignString() {
  var timeStamp = getTimeStamp();
  var random = getRandom();
  var packageName = getPackageName();
  return "PackageName=$packageName&timeStamp=$timeStamp&Random=$random&SignKey=${getSignKey(timeStamp, random)}";
}

encryptedString(String param) {
  DateTime now = DateTime.now();
  int i = now.weekday;
  int i2 = now.day;
  int i3 = i2 - i;
  if (i3 <= 10) {
    i3 += 7;
  }
  String encryptedString = '';
  for (int j = 0; j < param.length; j++) {
    int charCode = param.codeUnitAt(j);
    encryptedString += String.fromCharCode(charCode + i3);
  }
  return encryptedString;
}
