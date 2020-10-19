import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

typedef String FormFieldFormatter<T>(T v);
typedef bool MaterialSearchFilter<T>(T v, String c);
typedef int MaterialSearchSort<T>(T a, T b, String c);
typedef Future<List<MaterialSearchResult>> MaterialResultsFinder(String c);
typedef void OnSubmit(String value);

/// 线路组件
class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult(
      {Key key,
      this.value,
      this.icon,
      this.onTap,
      this.routeName,
      this.routeNameExt,
      this.index})
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
  final String routeNameExt;

  /// 显示图标(暂时没用上)
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(icon),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: this.onTap,
      title: AutoSizeText(
        routeName,
      ),
      subtitle: AutoSizeText(
        routeNameExt,
      ),
    );
  }
}

/// 搜索框，跳往搜索页
class MaterialSearchInput<T> extends StatefulWidget {
  MaterialSearchInput({
    Key key,
    this.placeholder,
    this.results,
    this.filter,
    this.sort,
  });

  /// 占位符
  final String placeholder;

  /// 所有选择项，从中检索出结果
  final List<MaterialSearchResult<T>> results;

  /// 输入过滤筛选
  final MaterialSearchFilter<T> filter;

  /// 排序
  final MaterialSearchSort<T> sort;

  @override
  _MaterialSearchInputState<T> createState() => _MaterialSearchInputState<T>();
}

class _MaterialSearchInputState<T> extends State<MaterialSearchInput<T>> {
  GlobalKey<FormFieldState<T>> _formFieldKey = GlobalKey<FormFieldState<T>>();

  /// 调整到线路列表搜索页
  _showMaterialSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Material(
            child: MaterialSearch<T>(
              barBackgroundColor: Theme.of(context).primaryColor,
              placeholder: widget.placeholder,
              results: widget.results,
              filter: widget.filter,
              sort: widget.sort,
            ),
          );
        },
      ),
    );
  }

  bool _isEmpty(field) {
    return field.value == null;
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMaterialSearch(context),
      child: FormField<T>(
        key: _formFieldKey,
        builder: (FormFieldState<T> field) {
          return InputDecorator(
            isEmpty: _isEmpty(field),
            decoration: InputDecoration(
              labelText: widget.placeholder,
              border: InputBorder.none,
              errorText: field.errorText,
            ),
            child: _isEmpty(field) ? null : Text(field.value.toString()),
          );
        },
      ),
    );
  }
}

/// 线路列表搜索页
class MaterialSearch<T> extends StatefulWidget {
  MaterialSearch({
    Key key,
    this.placeholder,
    this.results,
    this.filter,
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
  final MaterialSearchSort<T> sort;

  /// 输入法点击完成时的处理函数
  final OnSubmit onSubmit;

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

  // 如果 widget.results 为空，那么启用该空列表
  List<MaterialSearchResult<T>> _results = [];

  // 用户输入的字符
  String _criteria = '';

  // 如果 widget.filter 为空，那么启用该过滤器
  _filter(dynamic v, String c) {
    return v
        .toString()
        .toLowerCase()
        .trim()
        .contains(RegExp(r'' + c.toLowerCase().trim() + ''));
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
      });
    });
  }

  Widget buildBody(List results) {
    if (_criteria.isEmpty) {
      return History();
    }
    if (results.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(children: results),
      );
    }
    return Center(
      child: Text("暂无数据"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 被选项
    var results =
        (widget.results ?? _results).where((MaterialSearchResult result) {
      if (widget.filter != null) {
        return widget.filter(result.value, _criteria);
      } else if (widget.results != null) {
        return _filter(result.value, _criteria);
      }
      return true;
    }).toList();

    // 排序
    if (widget.sort != null) {
      results.sort((a, b) => widget.sort(a.value, b.value, _criteria));
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration.collapsed(hintText: widget.placeholder),
          onSubmitted: (String value) {
            if (widget.onSubmit != null) {
              widget.onSubmit(value);
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
      child: Text(
        "这是一个即将完善的搜索记录",
      ),
    );
  }
}
