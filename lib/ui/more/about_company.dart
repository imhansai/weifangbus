import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutCompany extends StatefulWidget {
  @override
  _AboutCompanyState createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("潍坊市公共交通总公司"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(40),
                ScreenUtil().setHeight(40),
                ScreenUtil().setWidth(40),
                ScreenUtil().setHeight(200),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(200),
                    child: Center(
                      child: Text(
                        "潍坊市公共交通总公司简介",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(60),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(1),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(13), right: ScreenUtil().setWidth(13)),
                    child: Container(
                      color: Colors.black12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(31),
                    ),
                    child: Text(
                      "        潍坊市公共交通总公司成立于1972年，是以经营城市客运为主的国有公益性公用企业。现有职工2936人，营运车辆1517台,营运线路96条，线路总长度1876.83千米，线网辐射九区一县(潍城区、奎文区、坊子区、寒亭区、高新技术产业开发区、综合保税区、滨海经济开发区、峡山生态经济开发区、经济技术开发区以及昌乐县)，日客流量达34.5万人次。\n        近年来，我们紧紧围绕城市建设和群众出行需要，内强素质，外树形象，擦亮公交窗口，勇担公益责任，全面提升服务能力和服务水平，公交事业实现又好又快发展。企业先后荣获“山东省先进基层党组织”、“山东省廉政文化示范点”、“山东省服务名牌”、“潍坊市最具社会责任感优秀企业”、“潍坊市平安建设先进单位”、“市级文明单位”等荣誉。",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
                        // ignore: unrelated_type_equality_checks
                        height: Platform.isAndroid ? ScreenUtil().setHeight(5) : ScreenUtil().setHeight(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
