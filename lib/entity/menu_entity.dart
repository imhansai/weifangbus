/// 菜单实体类
import 'package:flutter/material.dart';

class MenuEntity {
  /// 颜色
  final Color color;

  /// 图标
  final IconData icon;

  /// 菜单名称
  final String menuText;

  /// 功能
  final GestureTapCallback? onTap;

  const MenuEntity({
    required this.color,
    required this.icon,
    required this.menuText,
    this.onTap,
  });
}
