import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weifangbus/view/home/search_input.dart';

/// 搜索栏
class SearchBar extends StatefulWidget {
  final List<MaterialSearchResult<String>> allRouteList;

  const SearchBar({Key key, this.allRouteList}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: ScreenUtil().setWidth(25),
                left: ScreenUtil().setWidth(25),
              ),
              child: Icon(
                Icons.search,
                size: ScreenUtil().setWidth(60),
                color: Theme.of(context).accentColor,
              ),
            ),
            Expanded(
              child: MaterialSearchInput(
                placeholder: "搜索线路",
                results: widget.allRouteList,
                filter: (dynamic value, String criteria) {
                  return value.toLowerCase().trim().contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}