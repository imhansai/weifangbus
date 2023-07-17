import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef bool MaterialSearchFilter<T>(T v, String c);
typedef int MaterialSearchSort<T>(T a, T b, String c);
typedef void OnSubmit(String value);

/// 线路组件
class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult(
      {Key? key,
      required this.value,
      this.icon,
      required this.onTap,
      required this.routeName,
      this.routeNameExt,
      required this.index})
      : super(key: key);

  /// 下标(暂时没用上)
  final int index;

  /// 值（过滤及排序）
  final String value;

  /// 回调函数
  final VoidCallback onTap;

  /// 线路名
  final String routeName;

  /// 起点-终点
  final String? routeNameExt;

  /// 显示图标(暂时没用上)
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: this.onTap,
      title: AutoSizeText(
        routeName,
      ),
    );
  }
}

/// 搜索框，跳往搜索页
class MaterialSearchInput<T> extends StatefulWidget {
  MaterialSearchInput({
    Key? key,
    required this.placeholder,
    required this.results,
    required this.filter,
    this.sort,
  });

  /// 占位符
  final String placeholder;

  /// 所有选择项，从中检索出结果
  final List<MaterialSearchResult<T>> results;

  /// 输入过滤筛选
  final MaterialSearchFilter<T> filter;

  /// 排序
  final MaterialSearchSort<T>? sort;

  @override
  _MaterialSearchInputState<T> createState() => _MaterialSearchInputState<T>();
}

class _MaterialSearchInputState<T> extends State<MaterialSearchInput<T>> {
  /// 调整到线路列表搜索页
  _showMaterialSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MaterialSearch<T>(
            barBackgroundColor: Theme.of(context).primaryColor,
            placeholder: widget.placeholder,
            results: widget.results,
            filter: widget.filter,
            sort: widget.sort,
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

/// 线路列表搜索页
class MaterialSearch<T> extends StatefulWidget {
  MaterialSearch({
    Key? key,
    required this.placeholder,
    required this.results,
    required this.filter,
    this.sort,
    this.onSubmit,
    this.barBackgroundColor = Colors.white,
    this.iconColor = Colors.black,
  }) : super(key: key);

  /// 占位符,提示字符
  final String placeholder;

  /// 被选项
  final List<MaterialSearchResult<T>> results;

  /// 过滤
  final MaterialSearchFilter<T> filter;

  /// 排序
  final MaterialSearchSort<T>? sort;

  /// 输入法点击完成时的处理函数
  final OnSubmit? onSubmit;

  /// appBar 的背景色
  final Color barBackgroundColor;

  /// 图标的颜色
  final Color iconColor;

  @override
  _MaterialSearchState<T> createState() => _MaterialSearchState<T>();
}

class _MaterialSearchState<T> extends State<MaterialSearch> {
  // 文本编辑控制器
  TextEditingController _controller = TextEditingController();

  // 用户输入的字符
  String _criteria = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
      });
    });
  }

  Widget buildBody(List<Widget> results) {
    if (_criteria.isEmpty) {
      return History();
    }
    if (results.isNotEmpty) {
      return SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: ListTile.divideTiles(
            tiles: results,
            context: context,
          ).toList(),
        ),
      );
    }
    return Center(
      child: Text("暂无数据"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 被选项
    var results = (widget.results).where((MaterialSearchResult result) {
      return widget.filter(result.value, _criteria);
    }).toList();

    // 排序
    if (widget.sort != null) {
      results.sort((a, b) => widget.sort!(a.value, b.value, _criteria));
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          cursorColor: Colors.cyan,
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration.collapsed(hintText: widget.placeholder),
          onSubmitted: (String value) {
            if (widget.onSubmit != null) {
              widget.onSubmit!(value);
            }
          },
        ),
        actions: _criteria.length == 0
            ? []
            : [
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.text = _criteria = '';
                      });
                    }),
              ],
      ),
      body: buildBody(results),
    );
  }
}

/// 历史记录面板
class History extends StatefulWidget {
  const History() : super();

  @override
  _History createState() => _History();
}

class _History extends State<History> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        AppLocalizations.of(context)!.searchHistory,
      ),
    );
  }
}
