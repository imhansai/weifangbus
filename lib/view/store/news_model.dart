import 'package:flutter/material.dart';
import 'package:weifangbus/api/ApiService.dart';
import 'package:weifangbus/entity/new_info_summary_entity.dart';

/// 资讯信息
class NewsModel with ChangeNotifier {
  ///  资讯信息
  ///
  ///  不能用var，使用指定类型。解决 type 'List<dynamic>' is not a subtype of type 'List<Headline>'
  List<NewInfoSummaryEntity> _showNewsList = List.empty(growable: true);

  List<NewInfoSummaryEntity> get showNewsList => _showNewsList;

  // api 服务
  final ApiService apiService = ApiService();

  Future refreshNewsList() async {
    _showNewsList = await apiService.fetchAllNews();
    notifyListeners();
  }

  NewsModel() {
    refreshNewsList();
  }
}
