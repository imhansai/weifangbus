import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/entity/headline_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

/// 资讯信息
class NewsModel with ChangeNotifier {
  ///  资讯信息
  ///
  ///  不能用var，使用指定类型。解决 type 'List<dynamic>' is not a subtype of type 'List<Headline>'
  List<Headline> _showNewsList = List();

  List<Headline> get showNewsList => _showNewsList;

  Future refreshNewsList() async {
    _showNewsList = await getNewsList();
    // 测试状态管理
    // _showNewsList = List();
    notifyListeners();
  }

  /// 请求资讯列表数据
  getNewsList() async {
    try {
      var uri = '/BusService/Query_ByNewInfoPartNP?index=1&${getSignString()}';
      Response response = await dio.get(uri);
      List<dynamic> list = response.data;
      List<Headline> newsList = list
          .map((dynamic) => EntityFactory.generateOBJ<Headline>(dynamic))
          .toList();
      print('请求 资讯信息 完毕');
      newsList ?? List();
      return newsList;
    } on DioError catch (e) {
      print(getErrorMsg(e, msg: "请求 资讯信息"));
      return Future.error(e);
    }
  }

  NewsModel() {
    refreshNewsList();
  }
}
