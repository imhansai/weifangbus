import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/entity/new_info_summary_entity.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

/// 资讯信息
class NewsModel with ChangeNotifier {
  ///  资讯信息
  ///
  ///  不能用var，使用指定类型。解决 type 'List<dynamic>' is not a subtype of type 'List<Headline>'
  List<NewInfoSummaryEntity> _showNewsList = List.empty(growable: true);

  List<NewInfoSummaryEntity> get showNewsList => _showNewsList;

  Future refreshNewsList() async {
    _showNewsList = await getNewsList();
    notifyListeners();
  }

  /// 请求资讯列表数据
  getNewsList() async {
    try {
      var uri =
          '/Query_ByNewInfoSummary?UseFor=0,1,3,8,10,11,14&${getSignString()}';
      Response response = await dio.get(uri);
      List<dynamic> list = response.data;
      List<NewInfoSummaryEntity> newsList = list
          .map((dynamic) => NewInfoSummaryEntity.fromJson(dynamic))
          .toList();
      print('请求 资讯信息 完毕');
      return newsList;
    } on DioException catch (e) {
      print(getErrorMsg(e, msg: "请求资讯信息"));
      return Future.error(e);
    }
  }

  NewsModel() {
    refreshNewsList();
  }
}
