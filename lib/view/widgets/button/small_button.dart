import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
class SmallButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  const SmallButton({super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor
        ),
        padding: const EdgeInsets.all(5),
        child:  Icon(
          icon,
          color: AppColors.white,
        ),
      ),
    );
  }
}
