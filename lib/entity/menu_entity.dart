/// 菜单实体类
import 'package:flutter/material.dart';

class MenuEntity {
  /// 颜色
  Color color;

  /// 图标
  IconData icon;

  /// 菜单名称
  String menuText;

  /// 功能
  Function function;

  MenuEntity(this.color, this.icon, this.menuText, this.function);
}
