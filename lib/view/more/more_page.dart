import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/view/more/about_company.dart';
import 'package:weifangbus/view/more/about_me.dart';
import 'package:weifangbus/view/more/about_software.dart';
import 'package:weifangbus/view/more/settings/settings.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).More),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          var tiles = <Widget>[
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
              title: Text(S.of(context).Settings),
              subtitle: Text(S.of(context).SettingsDesc),
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
              title: Text(S.of(context).QQGroup),
              subtitle: Text(S.of(context).QQGroupDesc),
              onTap: () {
                _joinQQGroup(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: Icon(
                Icons.business,
                color: Colors.brown,
              ),
              title: Text(S.of(context).Company),
              subtitle: Text(S.of(context).CompanyDesc),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AboutCompany();
                    },
                  ),
                );
              },
            ),
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: Icon(
                MyIcons.software,
                color: Colors.black87,
              ),
              title: Text(S.of(context).AboutSoftWare),
              onTap: () {
                showAboutSoftWareDialog(context, orientation);
              },
            ),
            ListTile(
              trailing: Icon(Icons.keyboard_arrow_right),
              leading: Icon(
                Icons.info,
                color: Colors.lightBlue,
              ),
              title: Text(S.of(context).Author),
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
          return Container(
            child: ListView(
              children: ListTile.divideTiles(
                tiles: tiles,
                context: context,
              ).toList(),
            ),
          );
        },
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
      Platform.isAndroid ? await launch(android_url) : await launch(ios_url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            width: 1.sw,
            child: AutoSizeText(
              S.of(context).NotInstalledQQ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(S.of(context).Ok),
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
