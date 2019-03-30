import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharesdk/sharesdk.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/ui/more/about_company.dart';
import 'package:weifangbus/ui/more/about_me.dart';
import 'package:weifangbus/ui/more/about_software.dart';
import 'package:weifangbus/ui/more/settings.dart';
import 'package:weifangbus/utils/fontUtil.dart';
import 'package:weifangbus/widget/list_item.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // iOS
    ShareSDKRegister register = ShareSDKRegister();

    register.setupWechat("wxe9bd4da0a6e470cb", "41fc6dd58e8ec6c0fde5402cd1ac9158");
    register.setupSinaWeibo("2731709630", "d37986d86e6c7d3c1508ed87086b5b78", "http://www.sharesdk.cn");
    register.setupQQ("1108255306", "EgcwxLZrBdztOnRY");
    ShareSDK.regist(register);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('更多'),
        centerTitle: true,
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
            ListItem(
              title: "潍坊市公共交通总公司",
              describe: "关于潍坊市公共交通总公司",
              icon: Icon(
                Icons.business,
                color: Colors.brown,
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
              title: "关于潍坊公交",
              icon: Icon(
                MyIcons.software,
                color: Colors.black54,
              ),
              onPressed: () {
                showAboutSoftWareDialog(context);
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
              title: "走近作者",
              // describe: "走近作者",
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
            ListItem(
              title: "分享",
              describe: "让更多人发现使用",
              icon: Icon(
                FontAwesome.getIconData("share-alt-square"),
                color: Colors.teal,
              ),
              onPressed: () {
                showShareMenu(context);
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

  void showShareMenu(BuildContext context) {
    // todo 需要确定参数
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "标题:潍坊公交",
          "文本:分享自潍坊公交",
          [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"
          ],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          null,
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          SSDKContentTypes.auto);
    ShareSDK.showMenu([ShareSDKPlatforms.qq, ShareSDKPlatforms.wechatSeries, ShareSDKPlatforms.sina], params,
        (SSDKResponseState state, ShareSDKPlatform platform, Map userData, Map contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
    print("--------------------------> state:" + state.toString());
    String title = "分享失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "分享成功";
        break;
      case SSDKResponseState.Fail:
        title = "分享失败";
        break;
      case SSDKResponseState.Cancel:
        title = "取消分享";
        break;
      default:
        title = state.toString();
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text(title),
            content: new Text(content != null ? content.toString() : ""),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
    );
  }
}
