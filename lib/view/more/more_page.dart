import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
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
    var tiles = <Widget>[
      ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: Icon(
          Icons.settings,
          color: Colors.blueGrey,
        ),
        title: Text('设置'),
        subtitle: Text('完美调控，尽在您的掌握'),
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
        title: Text('QQ群'),
        subtitle: Text('加入QQ群交流反馈'),
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
        title: Text('潍坊市公共交通总公司'),
        subtitle: Text('关于潍坊市公共交通总公司'),
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
        title: Text('关于潍坊公交'),
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
        title: Text('走近作者'),
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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('更多'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: ListTile.divideTiles(
            tiles: tiles,
            context: context,
          ).toList(),
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
      Platform.isAndroid ? await launch(android_url) : await launch(ios_url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            width: 1.sw,
            child: AutoSizeText(
              "抱歉，检测到您还未安装QQ客户端!",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
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
