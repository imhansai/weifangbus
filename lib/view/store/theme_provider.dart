import 'package:flutter/material.dart';

/// 外观
class ThemeProvider with ChangeNotifier {
  /// 0/浅色 1/深色 2/跟随系统
  int _modelValue;

  int get modelValue => _modelValue;

  changeModel(int modelValue) {
    _modelValue = modelValue;
    notifyListeners();
  }
}
