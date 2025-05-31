import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:easy_refresh_bubbles/easy_refresh_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/view/home/news/news_detail.dart';
import 'package:weifangbus/view/store/news_model.dart';

/// 资讯列表页
class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  /// 方便 showSnackBar
  final GlobalKey<ScaffoldState> _newsListKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // 获取资讯信息

  }

  // 展示 SnackBar
  void showSnackBar(String snackStr) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 随着资讯信息的变化而变化
    var _showNewsList = context.watch<NewsModel>();
    // // 是否有数据
    // var noData = _showNewsList.showNewsList.isEmpty;

    var showNewsList = _showNewsList.showNewsList;
    var tiles = showNewsList
        .map((e) => ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text(
                DateFormat(AppLocalizations.of(context)!.newsDate)
                    .format(DateTime.parse(e.releaseTime!))
                    .toString(),
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
              subtitle: AutoSizeText(
                e.title!,
                style: TextStyle(
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return InformationDetail(
                        headLine: e,
                      );
                    },
                  ),
                ),
              },
            ))
        .toList();

    return Scaffold(
      key: _newsListKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.news),
      ),
      body: EasyRefresh(
        header: BubblesHeader(),
        footer: BubblesFooter(),
        onRefresh: () async {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult != ConnectivityResult.none) {
            try {
              await context.read<NewsModel>().refreshNewsList();
              showSnackBar(AppLocalizations.of(context)!.refreshSuccess);
            } catch (e) {
              print('刷新资讯信息出错::: $e');
              showSnackBar(AppLocalizations.of(context)!.requestDataFailure);
            }
          } else {
            showSnackBar(
                AppLocalizations.of(context)!.notConnectedToAnyNetwork);
          }
        },
        child: ListView(
          children: tiles,
        ),
      ),
    );
  }
}
