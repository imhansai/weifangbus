import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:weifangbus/util/font_util.dart';

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
            expandedHeight: 180,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/avatar.jpeg",
                    width: 80,
                  ),
                ),
              ),
              title: Text(
                "imhansai",
                style: TextStyle(
                  fontSize: 25,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10.0,
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
                                  AppLocalizations.of(context)!.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(context)!.nameDesc,
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
                                  AppLocalizations.of(context)!.age,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(context)!.ageDesc,
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
                                  AppLocalizations.of(context)!.city,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(context)!.cityDesc,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10.0,
                      ),
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
                                  'https://github.com/imhansai',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  launchUrlString("https://github.com/imhansai");
                                },
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10.0,
                      ),
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
                                AppLocalizations.of(context)!.phone,
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
                                launchUrlString("tel:15553665833");
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!.eMail,
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
                                launchUrlString(
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
      await launchUrlString(url);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Text("抱歉，检测到您还未安装QQ客户端!"),
            ),
            actions: <Widget>[
              OutlinedButton(
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
