import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

/// 获取时间戳
String _getTimeStamp() => DateFormat("yyyyMMddHHmmss").format(DateTime.now()).toString();

/// 获取随机数
String _getRandom() => (100 + Random().nextInt(900)).toString();

/// 生成签名密钥
String _getSignKey(timeStamp, random) {
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

String _getPackageName() {
  return "com.hisense.wfbus2";
}

/// 获取参数
String getSignString() {
  var timeStamp = _getTimeStamp();
  var random = _getRandom();
  var packageName = _getPackageName();
  return "PackageName=$packageName&timeStamp=$timeStamp&Random=$random&SignKey=${_getSignKey(timeStamp, random)}";
}

/// 参数加密
String encryptedString(String param) {
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
