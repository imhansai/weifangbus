import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weifangbus/entity/home/install_basic_info_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

class AboutCompany extends StatefulWidget {
  @override
  _AboutCompanyState createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  // 展示 SnackBar
  void showSnackBar(String snackStr) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(snackStr),
      ),
    );
  }

  Future<InstallBasicInfoEntity> getInstallBasicInfoEntity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        var uri = "/BusService/Query_InstallBasicInfo?" + getSignString();
        print(uri);
        Response response = await dio.get(uri);
        var installBasicInfoEntity = EntityFactory.generateOBJ<InstallBasicInfoEntity>(response.data);
        print("请求关于企业数据完毕");
        return installBasicInfoEntity;
      } on DioError catch (e) {
        print('请求关于企业数据出错::: $e');
        showSnackBar('请求数据失败，请尝试切换网络后重试!');
        return Future.error(e);
      }
    } else {
      showSnackBar('设备未连接到任何网络,请连接网络后重试!');
      return Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("潍坊市公共交通总公司"),
      ),
      body: FutureBuilder(
        future: getInstallBasicInfoEntity(),
        builder: (context, result) {
          // 加载中.展示加载动画
          if (result.connectionState == ConnectionState.active || result.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setWidth(100),
                    child: SpinKitRotatingPlain(
                      color: Colors.lightGreen,
                      size: ScreenUtil().setWidth(100),
                    ),
                  ),
                  Container(
                    child: Text('加载中...'),
                  )
                ],
              ),
            );
          }

          // 加载完成
          if (result.connectionState == ConnectionState.done) {
            if (result.hasData) {
              var installBasicInfoEntity = result.data as InstallBasicInfoEntity;
              return SingleChildScrollView(
                child: Html(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                  ),
                  data: installBasicInfoEntity.aboutus,
                  defaultTextStyle: TextStyle(
                    fontFamily: 'serif',
                    fontSize: ScreenUtil().setSp(50),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
