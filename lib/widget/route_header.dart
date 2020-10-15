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
      // xxx -> xxx; 首末班、票价
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(20),
          ),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              AutoSizeText(
                '${widget.firstStationName} ➡️ ${widget.lastStationName}',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(50),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // 首末班 + 票价
              Expanded(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    // 首末班
                    Expanded(
                      child: AutoSizeText(
                        widget.firstAndLastBus,
                      ),
                    ),
                    // 票价
                    Expanded(
                      child: AutoSizeText(
                        widget.routePrice.contains('票价')
                            ? widget.routePrice
                            : '票价: ${widget.routePrice} 元',
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // 换向
      widget.transDirection
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      Icon(
                        Icons.swap_vert_sharp,
                      ),
                      Text(
                        '换向',
                      ),
                    ],
                  ),
                ),
                onTap: widget.transDirectionFun,
              ),
            )
          : SizedBox(),
    ];
    return Container(
      color: Colors.grey[200],
      height: ScreenUtil().setHeight(200),
      child: Flex(
        direction: Axis.horizontal,
        children: widgets,
      ),
    );
  }
}
