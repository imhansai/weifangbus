import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// 线路详情头部信息
class RouteHeader extends StatefulWidget {
  /// 线路名称
  final String routeName;

  /// 起点站
  final String firstStationName;

  /// 终点站
  final String lastStationName;

  /// 是否换向
  final bool transDirection;

  /// 换向内容
  final VoidCallback transDirectionFun;

  /// 首末班
  final String firstAndLastBus;

  /// 票价
  final String routePrice;

  const RouteHeader(
      {Key key,
      this.routeName,
      this.firstStationName,
      this.lastStationName,
      this.transDirection,
      this.transDirectionFun,
      this.firstAndLastBus,
      this.routePrice})
      : super(key: key);

  @override
  _RouteHeaderState createState() => _RouteHeaderState();
}

class _RouteHeaderState extends State<RouteHeader> {
  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[
      // 线路名称
      Expanded(
        flex: 3,
        child: Padding(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(20),
          ),
          child: AutoSizeText(
            widget.routeName,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(70),
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      // xxx -> xxx
      Expanded(
        flex: 4,
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setHeight(20),
            right: ScreenUtil().setWidth(20),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              // 起点站
              Expanded(
                // flex: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.orange[700]],
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(20),
                    ),
                    child: AutoSizeText(
                      widget.firstStationName,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(50),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              // 方向 icon + 换向
              Expanded(
                // flex: 1,
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.forward,
                        color: Colors.orange,
                      ),
                    ),
                    // 换向
                    widget.transDirection
                        ? Expanded(
                            child: RaisedButton.icon(
                              color: Colors.green,
                              icon: Icon(
                                Icons.swap_horiz,
                                size: 15,
                              ),
                              label: Text(
                                '换向',
                                style: TextStyle(fontSize: 13),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: widget.transDirectionFun,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              // 终点站
              Expanded(
                // flex: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.orange[700]],
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(20),
                    ),
                    child: AutoSizeText(
                      widget.lastStationName,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(50),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // 首末班 + 票价
      Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            // top: ScreenUtil().setHeight(20),
            right: ScreenUtil().setHeight(20),
            bottom: ScreenUtil().setHeight(20),
          ),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              // 首末班
              Expanded(
                child: AutoSizeText(
                  widget.firstAndLastBus,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                  ),
                  textAlign: TextAlign.center,
                ),
                flex: 4,
              ),
              // 空白填充
              Expanded(
                child: Container(),
                flex: 1,
              ),
              // 票价
              Expanded(
                child: AutoSizeText(
                  widget.routePrice.contains('票价')
                      ? widget.routePrice
                      : '票价: ${widget.routePrice} 元',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                  ),
                  textAlign: TextAlign.center,
                ),
                flex: 4,
              )
            ],
          ),
        ),
      )
    ];
    return Container(
      color: Colors.blueGrey,
      height: ScreenUtil().setHeight(400),
      width: double.infinity,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: widgets,
      ),
    );
  }
}
