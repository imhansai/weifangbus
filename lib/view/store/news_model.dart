import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/entity/headline_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

// 资讯信息
class NewsModel with ChangeNotifier {
  //  资讯信息
  List<Headline> _showNewsList = List();

  List<Headline> get showNewsList => _showNewsList;

  Future refreshNewsList() async {
    _showNewsList = await getNewsList();
    notifyListeners();
  }

  // 请求资讯列表数据
  Future<List<Headline>> getNewsList() async {
    try {
      var uri = "/BusService/Query_ByNewInfoPartNP?index=1&" + getSignString();
      Response response = await dio.get(uri);
      List<dynamic> list = response.data;
      List<Headline> newsList = list.map((dynamic) => EntityFactory.generateOBJ<Headline>(dynamic)).toList();
      print('请求资讯列表数据完毕');
      if (newsList == null) {
        newsList = List();
      }
      return newsList;
    } on DioError catch (e) {
      print('请求资讯列表数据出错::: $e');
      return Future.error(e);
    }
  }

  NewsModel() {
    refreshNewsList();
  }
}
