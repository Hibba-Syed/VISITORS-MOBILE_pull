import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';

class ActionButton extends StatelessWidget {
  final String? text;
  final String? image;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? imageColor;
  final VoidCallback? onPressed;
  final double? buttonWidth;
  const ActionButton({super.key,
    this.text,
    this.image,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.imageColor,
    this.textColor,
    this.onPressed,
    this.buttonWidth,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: buttonWidth ,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10,vertical: verticalPadding ?? 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor ?? AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              SvgPicture.asset(image ?? "", colorFilter: ColorFilter.mode(
                imageColor ?? AppColors.white,
                BlendMode.srcIn,
              ),height: 15),
              const Gap(5),
              Text(text ?? "",
                  style: TextStyle(
                    color: textColor ?? AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                  //AppTextStyles.style12white500
              ),
          ],
        ),
      ),
    );
  }
}
