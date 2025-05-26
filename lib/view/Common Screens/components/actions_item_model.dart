import 'package:flutter/material.dart';


class ActionsItemModel {
  final String title;
  final int? count;
  final String iconPath;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color forGroundColor;
  ActionsItemModel({
    required this.title,
     this.count,
    required this.iconPath,
    required this.onTap,
    required this.backgroundColor,
    required this.forGroundColor,
  });
}
