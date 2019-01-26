import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:weifangbus/entity/home/news_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/utils/dioUtil.dart';

Future main() async {
  try {
    Response response;
    var uri = "/BusService/Query_ByNewInfoPartNP?index=1&" + getSignString();
    print(uri);
    response = await dio.get(uri);
    List<dynamic> list = response.data;
    List<NewsEntity> newsList = list.map((dynamic) => EntityFactory.generateOBJ<NewsEntity>(dynamic)).toList();
    print(newsList.map((news) => print(news.toJson().toString())));
  } catch (e) {
    print('请求出现问题');
    print(e);
  }
}

/// 获取时间戳
getTimeStamp() => new DateFormat("yyyyMMddHHmmss").format(new DateTime.now()).toString();

/// 获取随机数
getRandom() => (100 + Random().nextInt(900)).toString();

/// 生成签名密钥
getSignKey(timeStamp, random) {
  // 59485eebe12042cba33e972f77834b6b 聊城
  // 55b73c446e914785862966abf9a29416 潍坊
  final appKey = "55b73c446e914785862966abf9a29416";
  var key = utf8.encode(appKey);
  var bytes = utf8.encode(timeStamp + random);

  // HMAC-SHA256
  var hmacSha256 = new Hmac(sha256, key);
  var digest = hmacSha256.convert(bytes);

  // print("HMAC digest as bytes: ${digest.bytes}");
  // print("HMAC digest as hex string: $digest");

  return digest.toString();
}

/// 获取参数
getSignString() {
  var timeStamp = getTimeStamp();
  var random = getRandom();
  return "TimeStamp=" + timeStamp + "&Random=" + random + "&SignKey=" + getSignKey(timeStamp, random);
}
