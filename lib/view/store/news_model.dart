import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

import '../../entity/head_line_entity.dart';

/// 资讯信息
class NewsModel with ChangeNotifier {
  ///  资讯信息
  ///
  ///  不能用var，使用指定类型。解决 type 'List<dynamic>' is not a subtype of type 'List<Headline>'
  List<HeadLineEntity> _showNewsList = List.empty(growable: true);

  List<HeadLineEntity> get showNewsList => _showNewsList;

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
      List<HeadLineEntity> newsList =
          list.map((dynamic) => HeadLineEntity.fromJson(dynamic)).toList();
      print('请求 资讯信息 完毕');
      newsList ?? List.empty(growable: true);
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
