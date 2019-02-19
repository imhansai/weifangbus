import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/ui/more/about_company.dart';
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
                color: Colors.orange,
              ),
              onPressed: () {},
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
              onPressed: () {},
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
}
