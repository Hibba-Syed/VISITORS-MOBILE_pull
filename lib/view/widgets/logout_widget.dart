import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resource/constants/app_colors.dart';
class LogoutWidget extends StatelessWidget {
  final Color? containerColor;
  final String? image;
  const LogoutWidget({super.key,
    this.containerColor,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child:  SvgPicture.asset(image ?? "", colorFilter: const ColorFilter.mode(
         AppColors.white,
        BlendMode.srcIn,
      ),height: 6),
    );
  }
}
