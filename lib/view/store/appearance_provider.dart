import 'package:flutter/material.dart';
import 'package:weifangbus/util/appearance.dart';

/// 外观
class AppearanceProvider with ChangeNotifier {
  Appearance _appearance;

  Appearance get appearance => _appearance;

  changeModel(Appearance appearance) {
    _appearance = appearance;
    notifyListeners();
  }
}
