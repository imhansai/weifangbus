import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/entity/install_basic_info_entity.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/generated/l10n.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';
import 'package:weifangbus/widget/future_common_widget.dart';

class AboutCompany extends StatefulWidget {
  @override
  _AboutCompanyState createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  Future<InstallBasicInfoEntity> _installBasicInfoFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Company),
      ),
      body: FutureBuilder<InstallBasicInfoEntity>(
        future: _installBasicInfoFuture,
        builder: (BuildContext context,
            AsyncSnapshot<InstallBasicInfoEntity> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return noneWidget(context);
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return activeOrWaitingWidget();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return RetryWidget(
                  onPressed: reTry,
                );
              } else if (snapshot.hasData) {
                var aboutUs = snapshot.data.aboutus;
                return buildOrientationBuilder(aboutUs);
              } else {
                // return Text('返回了个寂寞');
                return RetryWidget(
                  onPressed: reTry,
                );
              }
              break;
            default:
              return Text('啥也木有,哈哈哈');
          }
        },
      ),
    );
  }

  OrientationBuilder buildOrientationBuilder(String aboutUs) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return SingleChildScrollView(
          child: Html(
            data: aboutUs,
            style: {
              // 标题居中
              'p[align="center"]': Style(
                textAlign: TextAlign.center,
              ),
              // 标题字体大小
              "strong": Style(
                fontSize: FontSize(
                    orientation == Orientation.portrait ? 60.sp : 30.sp),
              ),
              // 内容字体大小
              'p[align="left"]': Style(
                fontSize: FontSize(
                    orientation == Orientation.portrait ? 50.sp : 25.sp),
                margin: EdgeInsets.only(
                  left: 40.w,
                  right: 40.w,
                ),
              ),
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _installBasicInfoFuture = _getInstallBasicInfoFuture();
  }

  /// 请求基础信息
  Future<InstallBasicInfoEntity> _getInstallBasicInfoFuture() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        Response response;
        var uri = '/BusService/Query_InstallBasicInfo?${getSignString()}';
        print(uri);
        response = await dio.get(uri);
        // print(response.data);
        var installBasicInfoEntity =
            EntityFactory.generateOBJ<InstallBasicInfoEntity>(response.data);
        return installBasicInfoEntity;
      } catch (e) {
        print(getErrorMsg(e, msg: '请求基础信息异常'));
        return Future.error(e);
      }
    } else {
      print('木有连接网络哦!');
      return Future.error(null);
    }
  }

  /// 重试
  void reTry() {
    setState(() {
      _installBasicInfoFuture = _getInstallBasicInfoFuture();
    });
  }
}
