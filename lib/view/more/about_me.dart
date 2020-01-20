import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/util/font_util.dart';
import 'package:weifangbus/widget/list_item.dart';

/// 关于我
class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: ScreenUtil().setHeight(600),
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: Container(
                  width: ScreenUtil().setWidth(280),
                  height: ScreenUtil().setHeight(280),
                  child: PreferredSize(
                    preferredSize: Size(
                      ScreenUtil().setWidth(80),
                      ScreenUtil().setHeight(80),
                    ),
                    child: Container(
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                          child: Image.asset(
                            "assets/images/head.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                "hanandjun",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(60),
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        ScreenUtil().setWidth(28),
                      ),
                      child: Card(
                          color: Colors.green,
                          child: Container(
                            padding: EdgeInsets.all(
                              ScreenUtil().setWidth(28),
                            ),
                            child: Column(
                              children: <Widget>[
                                ListItem(
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  title: "姓名",
                                  titleColor: Colors.white,
                                  describe: "韩塞",
                                  describeColor: Colors.white,
                                ),
                                ListItem(
                                  icon: EmptyIcon(),
                                  title: "年龄",
                                  titleColor: Colors.white,
                                  describe: "25岁",
                                  describeColor: Colors.white,
                                ),
                                ListItem(
                                  icon: EmptyIcon(),
                                  title: "所在城市",
                                  titleColor: Colors.white,
                                  describe: "山东潍坊",
                                  describeColor: Colors.white,
                                )
                              ],
                            ),
                          )),
                    ),
                    // 内容
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        ScreenUtil().setWidth(28),
                      ),
                      child: Card(
                          color: Colors.blue,
                          child: Container(
                            padding: EdgeInsets.all(
                              ScreenUtil().setWidth(28),
                            ),
                            child: Column(
                              children: <Widget>[
                                ListItem(
                                  icon: Icon(
                                    MyIcons.qq,
                                    color: Colors.white,
                                  ),
                                  title: "添加QQ",
                                  titleColor: Colors.white,
                                  describe: "724149270",
                                  describeColor: Colors.white,
                                  onPressed: () {
                                    _joinQQ(context);
                                  },
                                ),
                                ListItem(
                                  icon: Icon(
                                    MyIcons.github,
                                    color: Colors.white,
                                  ),
                                  title: "GitHub",
                                  titleColor: Colors.white,
                                  describe: "https://github.com/hanandjun",
                                  describeColor: Colors.white,
                                  onPressed: () {
                                    launch("https://github.com/hanandjun");
                                  },
                                )
                              ],
                            ),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        ScreenUtil().setWidth(28),
                      ),
                      child: Card(
                        color: Colors.teal,
                        child: Container(
                          padding: EdgeInsets.all(
                            ScreenUtil().setWidth(28),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListItem(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                title: "手机号",
                                titleColor: Colors.white,
                                describe: "15553665833",
                                describeColor: Colors.white,
                                onPressed: () {
                                  launch("tel:15553665833");
                                },
                              ),
                              ListItem(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                title: "邮件",
                                titleColor: Colors.white,
                                describe: "imhansai@foxmail.com",
                                describeColor: Colors.white,
                                onPressed: () {
                                  launch("mailto:imhansai@foxmail.com?subject=WeiFang-Bus-Feedback");
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  /// 加入QQ群
  _joinQQ(BuildContext context) async {
    const url = "mqqwpa://im/chat?chat_type=wpa&uin=724149270&version=1&src_type=web&web_src=qietu.cn";
    try {
      await launch(url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
          );
        },
      );
    }
  }
}
