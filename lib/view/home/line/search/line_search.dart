import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/view/home/line/search/line_search_history.dart';

typedef bool LineSearchFilter(String values, String input);

/// 线路列表搜索页
class LineSearch extends StatefulWidget {
  LineSearch({
    Key? key,
    required this.placeholder,
    required this.results,
    required this.filter,
  }) : super(key: key);

  /// 占位符,提示字符
  final String placeholder;

  /// 线路组件
  final List<LineSearchValues> results;

  /// 过滤
  final LineSearchFilter filter;

  @override
  _LineSearchState createState() => _LineSearchState();
}

class _LineSearchState<T> extends State<LineSearch> {
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildBody(List<Widget> results) {
    // 历史界面
    if (_criteria.isEmpty) {
      return LineSearchHistory();
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
    var results = (widget.results).where((LineSearchValues result) {
      return widget.filter(result.routeName, _criteria);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          cursorColor: Colors.cyan,
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration.collapsed(hintText: widget.placeholder),
        ),
        actions: [
          Visibility(
            visible: _criteria.length != 0,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _controller.text = _criteria = '';
                });
              },
            ),
          ),
        ],
      ),
      body: buildBody(results),
    );
  }
}

/// 单个线路的控件
class LineSearchValues extends StatelessWidget {
  const LineSearchValues({
    Key? key,
    required this.index,
    required this.routeName,
    this.icon = Icons.directions_bus,
    required this.onTap,
  }) : super(key: key);

  /// 下标
  final int index;

  /// 线路名(过滤及排序)
  final String routeName;

  /// 回调函数
  final VoidCallback onTap;

  /// 图标
  final IconData icon;

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
