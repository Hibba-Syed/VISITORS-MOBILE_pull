import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resource/constants/app_colors.dart';
class LogoutWidget extends StatelessWidget {
  final Color? backgroundColor;
  final String? image;
  final VoidCallback? onPressed;
  const LogoutWidget({super.key,
    this.backgroundColor,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onPressed,
      child: Container(
        height: 25,
        width: 25,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child:  SvgPicture.asset(image ?? "", colorFilter: const ColorFilter.mode(
           AppColors.white,
          BlendMode.srcIn,
        ),height: 6),
      ),
    );
  }
}
