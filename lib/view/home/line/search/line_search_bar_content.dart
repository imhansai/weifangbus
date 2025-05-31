import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:weifangbus/view/home/line/search/line_search.dart';

/// 搜索框，点击跳往搜索页
class LineSearchBarContent extends StatefulWidget {
  LineSearchBarContent({
    Key? key,
    required this.placeholder,
    required this.results,
    required this.filter,
  });

  /// 占位符
  final String placeholder;

  /// 所有选择项，从中检索出结果
  final List<LineSearchValues> results;

  /// 输入过滤筛选
  final LineSearchFilter filter;

  @override
  _LineSearchBarContentState createState() => _LineSearchBarContentState();
}

class _LineSearchBarContentState extends State<LineSearchBarContent> {
  /// 调整到线路列表搜索页
  _showMaterialSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LineSearch(
            placeholder: widget.placeholder,
            results: widget.results,
            filter: widget.filter,
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMaterialSearch(context),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.searchLine,
          icon: Icon(
            Icons.search,
          ),
          border: InputBorder.none,
          enabled: false,
        ),
      ),
    );
  }
}
