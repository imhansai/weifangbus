import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/font_util.dart';

/// 关于我
class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight:
                orientation == Orientation.portrait ? 500.h : 1000.h,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/avatar.jpeg",
                    width: orientation == Orientation.portrait ? 260.w : 130.w,
                  ),
                ),
              ),
              title: Text(
                "hanandjun",
                style: TextStyle(
                  fontSize:
                      orientation == Orientation.portrait ? 50.ssp : 25.ssp,
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
                    Padding(
                      padding: EdgeInsets.all(
                        28.w,
                      ),
                      child: Card(
                          color: Colors.green,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  S.of(context).Name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  S.of(context).NameDesc,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.access_time,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  S.of(context).Age,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  S.of(context).AgeDesc,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  S.of(context).City,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  S.of(context).CityDesc,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    // 内容
                    Padding(
                      padding: EdgeInsets.all(28.w),
                      child: Card(
                          color: Colors.blue,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  MyIcons.qq,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'QQ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  '724149270',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  _joinQQ(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  MyIcons.github,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'GitHub',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  'https://github.com/hanandjun',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  launch("https://github.com/hanandjun");
                                },
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(28.w),
                      child: Card(
                        color: Colors.teal,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              title: Text(
                                S.of(context).Phone,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                '15553665833',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                launch("tel:15553665833");
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              title: Text(
                                S.of(context).EMail,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                'imhansai@foxmail.com',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                launch(
                                    "mailto:imhansai@foxmail.com?subject=WeiFang-Bus-Feedback");
                              },
                            )
                          ],
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
    const url =
        "mqqwpa://im/chat?chat_type=wpa&uin=724149270&version=1&src_type=web&web_src=qietu.cn";
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
