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
    return Scaffold(
      appBar: AppBar(
        title: Text('外观管理'),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text(
                ThemeUtil.modelValue2String(0),
              ),
              onTap: () {
                _showAndSetTheme(context, 0);
              },
              trailing: _modelValue == 0 ? Text('已选择') : SizedBox(),
            ),
            ListTile(
              title: Text(
                ThemeUtil.modelValue2String(1),
              ),
              onTap: () {
                _showAndSetTheme(context, 1);
              },
              trailing: _modelValue == 1 ? Text('已选择') : SizedBox(),
            ),
            ListTile(
              title: Text(
                ThemeUtil.modelValue2String(2),
              ),
              onTap: () {
                _showAndSetTheme(context, 2);
              },
              trailing: _modelValue == 2 ? Text('已选择') : SizedBox(),
            ),
          ],
        ).toList(),
      ),
    );
  }
}
