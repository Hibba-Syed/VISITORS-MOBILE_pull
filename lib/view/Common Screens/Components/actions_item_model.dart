import 'package:flutter/material.dart';

import '../../../resource/constants/images.dart';

class ActionsItemModel {
  final String title;
  final String count;
  final String iconPath;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color forGroundColor;
  ActionsItemModel({
    required this.title,
    required this.count,
    required this.iconPath,
    required this.onTap,
    required this.backgroundColor,
    required this.forGroundColor,
  });
}
