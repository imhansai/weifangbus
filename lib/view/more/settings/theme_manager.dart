import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weifangbus/util/appearance.dart';
import 'package:weifangbus/util/theme_util.dart';
import 'package:weifangbus/view/store/appearance_provider.dart';

/// 外观管理
class AppearanceManager extends StatefulWidget {
  @override
  _AppearanceManagerState createState() => _AppearanceManagerState();
}

class _AppearanceManagerState extends State<AppearanceManager> {
  Appearance _appearance = Appearance.auto;

  /// 获取选择的外观
  _getAppearance() async {
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

  /// 展示和设置外观
  _showAndSetAppearance(BuildContext context, Appearance appearance) {
    print('外观切换至: ${AppearanceUtil.appearanceStr(context, appearance)}');
    AppearanceUtil.saveAppearance(appearance);
    setState(() {
      _appearance = appearance;
      context.read<AppearanceProvider>().changeModel(appearance);
    });
  }

  @override
  Widget build(BuildContext context) {
    var tiles = Appearance.values
        .map((e) => ListTile(
              title: Text(
                AppearanceUtil.appearanceStr(context, e),
              ),
              onTap: () {
                _showAndSetAppearance(context, e);
              },
              trailing: _appearance == e ? Text(AppLocalizations.of(context)!.selected) : SizedBox(),
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('外观管理'),
      ),
      body: ListView(
        children: tiles,
      ),
    );
  }
}
