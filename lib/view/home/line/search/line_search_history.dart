import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';

/// 历史记录面板
class LineSearchHistory extends StatefulWidget {
  const LineSearchHistory() : super();

  @override
  _LineSearchHistory createState() => _LineSearchHistory();
}

class _LineSearchHistory extends State<LineSearchHistory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        AppLocalizations.of(context)!.searchHistory,
      ),
    );
  }
}
