import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';

/// 线路详情头部信息
class RouteHeader extends StatefulWidget {
  /// 线路名称
  final String? routeName;

  /// 起点站
  final String? firstStationName;

  /// 终点站
  final String? lastStationName;

  /// 是否换向
  final bool? transDirection;

  /// 换向内容
  final VoidCallback? transDirectionFun;

  /// 首末班
  final String? firstAndLastBus;

  /// 票价
  final String? routePrice;

  const RouteHeader(
      {Key? key,
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
        flex: 3,
        child: Padding(
          padding: EdgeInsets.all(
            20.0,
          ),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              // 始发站 -> 终点站
              AutoSizeText(
                '${widget.firstStationName} ➡️ ${widget.lastStationName}',
                style: TextStyle(
                  fontSize: 20.0,
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
                      child: Text(
                        widget.firstAndLastBus ?? '',
                      ),
                    ),
                    // 票价
                    Expanded(
                      child: AutoSizeText(
                        widget.routePrice!.contains('票价') ? widget.routePrice! : '票价: ${widget.routePrice!} 元',
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
      Visibility(
        visible: widget.transDirection ?? false,
        child: InkWell(
          onTap: widget.transDirectionFun,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                Icon(
                  Icons.swap_vert_sharp,
                ),
                AutoSizeText(
                  AppLocalizations.of(context)!.reversing,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return Container(
      height: 130.0,
      child: Flex(
        direction: Axis.horizontal,
        children: widgets,
      ),
    );
  }
}
