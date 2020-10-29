import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/store/theme_provider.dart';

/// 外观管理
class ThemeManager extends StatefulWidget {
  @override
  _ThemeManagerState createState() => _ThemeManagerState();
}

class _ThemeManagerState extends State<ThemeManager> {
  /// 0/浅色 1/深色 2/跟随系统
  int _modelValue;

  /// 获取选择的外观值
  _getModelValue() async {
    var modelValue = await ThemeUtil.getModelValue();
    setState(() {
      _modelValue = modelValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _getModelValue();
  }

  /// 展示和设置外观
  _showAndSetTheme(BuildContext context, int modelValue) {
    print('外观切换至: ${ThemeUtil.modelValue2String(modelValue)}');
    ThemeUtil.saveModelValue(modelValue);
    setState(() {
      _modelValue = modelValue;
      context.read<ThemeProvider>().changeModel(modelValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var tiles = ThemeAppearance.values
        .map((e) => ListTile(
              title: Text(
                ThemeUtil.modelValue2String(e.index),
              ),
              onTap: () {
                _showAndSetTheme(context, e.index);
              },
              trailing: _modelValue == e.index ? Text('已选择') : SizedBox(),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('外观管理'),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList(),
      ),
    );
  }
}

/// 主题外观
enum ThemeAppearance { light, dark, auto }
