import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/more/settings/theme_manager.dart';
import 'package:weifangbus/view/store/appearance_provider.dart';

/// 设置页
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  /// 选择的外观
  Appearance _appearance = Appearance.auto;

  @override
  Widget build(BuildContext context) {
    var appearance = context.watch<AppearanceProvider>().appearance;
    if (appearance != null) {
      _appearance = appearance;
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
                Icons.nights_stay,
                color: Colors.blue,
              ),
              title: Text('外观管理'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AppearanceManager();
                    },
                  ),
                );
              },
              trailing: Text(AppearanceUtil.appearanceStr(_appearance)),
            ),
          ],
        ).toList(),
      ),
    );
  }

  _getAppearance() async {
    // print('外观设置 初始化');
    var appearance = await AppearanceUtil.getAppearance();
    setState(() {
      _appearance = appearance;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAppearance();
  }
}
