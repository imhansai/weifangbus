import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/view/more/about_me.dart';
import 'package:weifangbus/view/more/about_software.dart';
import 'package:weifangbus/view/more/settings/settings.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var tiles = <Widget>[
      ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: Icon(
          Icons.settings,
          color: Colors.blueGrey,
        ),
        title: Text(AppLocalizations.of(context)!.settings),
        subtitle: Text(AppLocalizations.of(context)!.settingsDesc),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Settings();
              },
            ),
          );
        },
      ),
      ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: Icon(
          MyIcons.qq,
          color: Colors.indigoAccent,
        ),
        title: Text(AppLocalizations.of(context)!.qQGroup),
        subtitle: Text(AppLocalizations.of(context)!.qQGroupDesc),
        onTap: () {
          _joinQQGroup(context);
        },
      ),
      ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: Icon(
          MyIcons.software,
          color: Colors.black87,
        ),
        title: Text(AppLocalizations.of(context)!.aboutSoftWare),
        onTap: () {
          showAboutSoftWareDialog(context);
        },
      ),
      ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: Icon(
          Icons.info,
          color: Colors.lightBlue,
        ),
        title: Text(AppLocalizations.of(context)!.author),
        // describe: "走近作者",
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AboutMe();
              },
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.more),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: tiles,
        ),
      ),
    );
  }

  /// 加入QQ群
  _joinQQGroup(BuildContext context) async {
    const android_url =
        "mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3D910wjZoyUj0kVCZVo0ecCe1BAGPuyvJR";
    const ios_url =
        "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=543279223&key=bc939c2996f276c67ab381417dc8440edf516db850e48138b07f3d39a5e7d18f&card_type=group&source=external";
    try {
      Platform.isAndroid ? await launchUrlString(android_url) : await launchUrlString(ios_url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            width: 1,
            child: AutoSizeText(
              AppLocalizations.of(context)!.notInstalledQQ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              child: Text(AppLocalizations.of(context)!.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
