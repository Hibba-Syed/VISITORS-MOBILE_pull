import 'package:flutter/material.dart';

class DrawerItemModel {
  final int index;
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  DrawerItemModel({
    required this.index,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });
}
