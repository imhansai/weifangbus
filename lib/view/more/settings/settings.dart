import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/more/settings/theme_manager.dart';
import 'package:weifangbus/view/store/theme_provider.dart';

/// 设置页
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  /// 选择的外观
  String _modelValueStr = '';

  @override
  Widget build(BuildContext context) {
    var modelValue = context.watch<ThemeProvider>().modelValue;
    // print('监听外观: $modelValue');
    if (modelValue != null) {
      // print('外观改变: $modelValue');
      _modelValueStr = ThemeUtil.modelValue2String(modelValue);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(
                Icons.nightlight_round,
                color: Colors.blue,
              ),
              title: Text('外观管理'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ThemeManager();
                    },
                  ),
                );
              },
              trailing: Text(_modelValueStr),
            ),
          ],
        ).toList(),
      ),
    );
  }

  _getModelValueStr() async {
    // print('外观设置 初始化');
    var modelValue = await ThemeUtil.getModelValue();
    var modelValue2String = ThemeUtil.modelValue2String(modelValue);
    setState(() {
      _modelValueStr = modelValue2String;
    });
  }

  @override
  void initState() {
    super.initState();
    _getModelValueStr();
  }
}
