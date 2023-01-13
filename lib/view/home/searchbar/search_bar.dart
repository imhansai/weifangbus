import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weifangbus/view/home/searchbar/search_input.dart';

/// 搜索栏
class SearchBar extends StatefulWidget {
  final List<MaterialSearchResult<String>> allRouteList;

  const SearchBar({Key? key, required this.allRouteList}) : super(key: key);

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
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: MaterialSearchInput(
            placeholder: AppLocalizations.of(context)!.searchLine,
            results: widget.allRouteList,
            filter: (dynamic value, String criteria) {
              return value
                  .toLowerCase()
                  .trim()
                  .contains(RegExp(r'' + criteria.toLowerCase().trim() + ''));
            },
          ),
        ),
      ),
    );
  }
}
