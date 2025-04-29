import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';

import '../../../resource/constants/app_constants.dart';
class SmallButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const SmallButton({super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor
        ),
        padding: const EdgeInsets.all(5),
        child:  Icon(
          icon,
          color: AppColors.white,
          size:  AppConstants.isTablet( context) ? 30 : 25,
        ),
      ),
    );
  }
}
