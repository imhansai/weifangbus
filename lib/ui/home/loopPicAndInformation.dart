import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weifangbus/entity/home/startUpBasicInfo.dart';
import 'package:weifangbus/entity_factory.dart';
import 'package:weifangbus/ui/home/informationDetail.dart';
import 'package:weifangbus/utils/dioUtil.dart';
import 'package:weifangbus/utils/requestParamsUtil.dart';

class LoopPicAndInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoopPicAndInformation();
  }
}

class _LoopPicAndInformation extends State<LoopPicAndInformation> {
  // 初始页json数据实体类
  var _startUpBasicInfoEntity;

  // 请求首页数据
  Future<StartUpBasicInfoEntity> getStartUpBasicInfoEntity() async {
    try {
      var uri = "/BusService/Query_StartUpBasicInfo?" + getSignString();
      print('uri::: ' + uri);
      Response response = await dio.get(uri);
      var startUpBasicInfoEntity = EntityFactory.generateOBJ<StartUpBasicInfoEntity>(response.data);
      print('请求 _startUpBasicInfoEntity 完毕');
      return startUpBasicInfoEntity;
    } catch (e) {
      print('获取 _startupbasicinfoEntity 出错::: ' + e);
      return new StartUpBasicInfoEntity();
    }
  }

  @override
  void initState() {
    _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
  }

  reTry() {
    setState(() {
      _startUpBasicInfoEntity = getStartUpBasicInfoEntity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _startUpBasicInfoEntity,
      builder: (context, result) {
        if (result.hasData) {
          var startUpBasicInfoEntity = result.data as StartUpBasicInfoEntity;
          return new Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: new BorderRadius.all(new Radius.circular(10)),
                        child: CachedNetworkImage(
                          placeholder: new Center(
                            child: SpinKitFadingCube(
                              color: Theme.of(context).primaryColor,
                              size: 25.0,
                            ),
                          ),
                          imageUrl: startUpBasicInfoEntity.slideshow[index].bannerurl,
                          fadeInCurve: Curves.easeIn,
                          fadeInDuration: Duration(seconds: 1),
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    itemCount: startUpBasicInfoEntity.slideshow.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    autoplay: true,
                    duration: 300,
                    autoplayDelay: 3000,
                    pagination: new SwiperPagination(),
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: new Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepOrangeAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                ' 资讯 ',
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                            ),
                            Expanded(
                              child: new Text(
                                ' ' + startUpBasicInfoEntity.headline[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: startUpBasicInfoEntity.headline.length,
                      autoplay: startUpBasicInfoEntity.headline.length > 1,
                      duration: 300,
                      autoplayDelay: 3000,
                      onTap: (int index) {
                        final Headline headLine = startUpBasicInfoEntity.headline[index];
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
                          return InformationDetail(
                            headLine: headLine,
                          );
                        }));
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (result.hasError) {
          return new Center(
            child: RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("请检查网络连接后重试"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: reTry,
            ),
          );
        }

        // By default, show a loading spinner
        return new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                child: SpinKitRotatingPlain(
                  color: Colors.lightGreen,
                  size: 25.0,
                ),
              ),
              Container(
                child: Text('加载中...'),
              )
            ],
          ),
        );
      },
    );
  }
}
