import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';

typedef String FormFieldFormatter<T>(T v);
typedef bool MaterialSearchFilter<T>(T v, String c);
typedef int MaterialSearchSort<T>(T a, T b, String c);
typedef Future<List<MaterialSearchResult>> MaterialResultsFinder(String c);
typedef void OnSubmit(String value);

/// 搜索结果内容显示面板
class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult({Key key, this.value, this.text, this.icon, this.onTap}) : super(key: key);

  // 值
  final String value;

  // 回调函数
  final VoidCallback onTap;

  // 显示文本
  final String text;

  // 显示图标
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: ScreenUtil().setHeight(180),
        padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(50),
          right: ScreenUtil().setWidth(50),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(50),
                    margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(50),
                    ),
                    child: Icon(icon),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(1),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(13), right: ScreenUtil().setWidth(13)),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 搜索页面
class MaterialSearch<T> extends StatefulWidget {
  MaterialSearch({
    Key key,
    this.placeholder,
    this.results,
    this.getResults,
    this.filter,
    this.sort,
    this.limit: 10,
    this.onSelect,
    this.onSubmit,
    this.barBackgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.leading,
  })  : assert(() {
          if (results == null && getResults == null || results != null && getResults != null) {
            throw AssertionError('Either provide a function to get the results, or the results.');
          }

          return true;
        }()),
        super(key: key);

  // 占位符,提示字符
  final String placeholder;

  // 被选项
  final List<MaterialSearchResult<T>> results;

  // 获得被选项的函数
  final MaterialResultsFinder getResults;

  // 过滤
  final MaterialSearchFilter<T> filter;

  // 排序
  final MaterialSearchSort<T> sort;

  // 取多少条显示
  final int limit;

  // 被选择时的处理函数
  final ValueChanged<T> onSelect;

  // 输入法点击完成时的处理函数
  final OnSubmit onSubmit;

  // appBar 的背景色
  final Color barBackgroundColor;

  // 图标的颜色
  final Color iconColor;

  final Widget leading;

  @override
  _MaterialSearchState<T> createState() => _MaterialSearchState<T>();
}

class _MaterialSearchState<T> extends State<MaterialSearch> {
  // 文本编辑控制器
  TextEditingController _controller = TextEditingController();

  // 是否在加载中
  bool _loading = false;

  // 如果 widget.results 为空，那么启用该空列表
  List<MaterialSearchResult<T>> _results = [];

  // 用户输入的字符
  String _criteria = '';

  // 如果 widget.filter 为空，那么启用该过滤器
  _filter(dynamic v, String c) {
    return v.toString().toLowerCase().trim().contains(RegExp(r'' + c.toLowerCase().trim() + ''));
  }

  @override
  void initState() {
    super.initState();

    if (widget.getResults != null) {
      _getResultsDebounced();
    }

    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
        if (widget.getResults != null) {
          _getResultsDebounced();
        }
      });
    });
  }

  Timer _resultsTimer;

  Future _getResultsDebounced() async {
    if (_results.length == 0) {
      setState(() {
        _loading = true;
      });
    }

    if (_resultsTimer != null && _resultsTimer.isActive) {
      _resultsTimer.cancel();
    }

    _resultsTimer = Timer(Duration(milliseconds: 400), () async {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = true;
      });

      var results = await widget.getResults(_criteria);

      if (!mounted) {
        return;
      }

      if (results != null) {
        setState(() {
          _loading = false;
          _results = results;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _resultsTimer?.cancel();
  }

  Widget buildBody(List results) {
    if (_criteria.isEmpty) {
      return History();
    } else if (_loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (results.isNotEmpty) {
      var content = SingleChildScrollView(child: Column(children: results));
      return content;
    }
    return Center(
      child: Text("暂无数据"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 被选项
    var results = (widget.results ?? _results).where((MaterialSearchResult result) {
      if (widget.filter != null) {
        return widget.filter(result.value, _criteria);
      }
      // only apply default filter if used the `results` option
      // because getResults may already have applied some filter if `filter` option was omited.
      else if (widget.results != null) {
        return _filter(result.value, _criteria);
      }

      return true;
    }).toList();

    // 排序
    if (widget.sort != null) {
      results.sort((a, b) => widget.sort(a.value, b.value, _criteria));
    }

    // 默认取 10 条
    results = results.take(widget.limit).toList();

    IconThemeData iconTheme = Theme.of(context).iconTheme.copyWith(color: widget.iconColor);

    return Scaffold(
      appBar: AppBar(
        leading: widget.leading,
        backgroundColor: widget.barBackgroundColor,
        iconTheme: iconTheme,
        title: TextField(
          cursorColor: Colors.white70,
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration.collapsed(hintText: widget.placeholder),
          style: Theme.of(context).textTheme.title,
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

class _MaterialSearchPageRoute<T> extends MaterialPageRoute<T> {
  _MaterialSearchPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings: const RouteSettings(),
    maintainState: true,
    bool fullscreenDialog: false,
  })  : assert(builder != null),
        super(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);
}

// 搜索框
class MaterialSearchInput<T> extends StatefulWidget {
  MaterialSearchInput({
    Key key,
    this.onSaved,
    this.validator,
    this.autovalidate,
    this.placeholder,
    this.formatter,
    this.results,
    this.getResults,
    this.filter,
    this.sort,
    this.onSelect,
  });

  final FormFieldSetter<T> onSaved;

  final FormFieldValidator<T> validator;

  final bool autovalidate;

  // 占位符
  final String placeholder;

  final FormFieldFormatter<T> formatter;

  // 所有选择项，从中检索出结果
  final List<MaterialSearchResult<T>> results;

  final MaterialResultsFinder getResults;

  // 输入过滤筛选
  final MaterialSearchFilter<T> filter;

  // 排序
  final MaterialSearchSort<T> sort;

  // 选择条目后响应事件
  final ValueChanged<T> onSelect;

  @override
  _MaterialSearchInputState<T> createState() => _MaterialSearchInputState<T>();
}

class _MaterialSearchInputState<T> extends State<MaterialSearchInput<T>> {
  GlobalKey<FormFieldState<T>> _formFieldKey = GlobalKey<FormFieldState<T>>();

  _buildMaterialSearchPage(BuildContext context) {
    return _MaterialSearchPageRoute<T>(
      builder: (BuildContext context) {
        return Material(
          child: MaterialSearch<T>(
            barBackgroundColor: Theme.of(context).primaryColor,
            placeholder: widget.placeholder,
            results: widget.results,
            getResults: widget.getResults,
            filter: widget.filter,
            sort: widget.sort,
            onSelect: widget.onSelect,
          ),
        );
      },
    );
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context).push(_buildMaterialSearchPage(context)).then((dynamic value) {});
  }

  bool get autovalidate {
    return widget.autovalidate ?? Form.of(context)?.widget?.autovalidate ?? false;
  }

  bool _isEmpty(field) {
    return field.value == null;
  }

  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.subhead;

    return InkWell(
      onTap: () => _showMaterialSearch(context),
      child: FormField<T>(
        key: _formFieldKey,
        validator: widget.validator,
        onSaved: widget.onSaved,
        autovalidate: autovalidate,
        builder: (FormFieldState<T> field) {
          return InputDecorator(
            isEmpty: _isEmpty(field),
            decoration: InputDecoration(
              labelText: widget.placeholder,
              border: InputBorder.none,
              errorText: field.errorText,
            ),
            child: _isEmpty(field)
                ? null
                : Text(widget.formatter != null ? widget.formatter(field.value) : field.value.toString(),
                    style: valueStyle),
          );
        },
      ),
    );
  }
}

/// 搜索框
class SearchInput extends StatelessWidget {
  final getResults;

  final ValueChanged<String> onSubmitted;

  final VoidCallback onSubmitPressed;

  SearchInput(this.getResults, this.onSubmitted, this.onSubmitPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.circular(4.0)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: Icon(Icons.search, size: 24.0, color: Theme.of(context).accentColor),
          ),
          Expanded(
            child: MaterialSearchInput(
              placeholder: '搜索 flutter 组件',
              getResults: getResults,
            ),
          ),
        ],
      ),
    );
  }
}

// 历史记录面板
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
