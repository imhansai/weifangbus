import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/ui/more/about_company.dart';
import 'package:weifangbus/ui/more/about_me.dart';
import 'package:weifangbus/ui/more/settings.dart';
import 'package:weifangbus/utils/fontUtil.dart';
import 'package:weifangbus/widget/list_item.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('更多'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListItem(
              title: "设置",
              describe: "完美调控，尽在您的掌握",
              icon: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Settings();
                    },
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(1),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
              child: Container(
                color: Colors.black12,
              ),
            ),
            ListItem(
              title: "QQ群",
              describe: "加入QQ群交流反馈",
              icon: Icon(
                MyIcons.qq,
                color: Colors.indigoAccent,
              ),
              onPressed: () {
                _joinQQGroup(context);
              },
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(1),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
              child: Container(
                color: Colors.black12,
              ),
            ),
            /*ListItem(
              title: "项目地址",
              describe: "期待大佬加入",
              icon: Icon(
                MyIcons.github,
                color: Colors.black87,
              ),
              onPressed: () {
                launch("https://github.com/hanandjun/weifangbus");
              },
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(1),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
              child: Container(
                color: Colors.black12,
              ),
            ),*/
            ListItem(
              title: "潍坊市公共交通总公司",
              describe: "关于潍坊市公共交通总公司",
              icon: Icon(
                Icons.business,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AboutCompany();
                    },
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(1),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
              child: Container(
                color: Colors.black12,
              ),
            ),
            ListItem(
              title: "关于我",
              describe: "走进作者",
              icon: Icon(
                Icons.info,
                color: Colors.lightBlue,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AboutMe();
                    },
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(1),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(5), right: ScreenUtil().setWidth(5)),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
              content: SingleChildScrollView(
                child: Text("抱歉，检测到您还未安装QQ客户端!"),
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
