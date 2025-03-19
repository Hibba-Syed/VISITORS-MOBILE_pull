import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../resource/constants/app_colors.dart';
import '../../resource/styles/styles.dart';

class IconTextContainerWidget extends StatelessWidget {
  final String? text;
  final String? image;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String? count;
  final bool? isCountContainer;
  final Color? imageColor;
  final VoidCallback? onPressed;
  const IconTextContainerWidget({super.key,
    this.text,
    this.image,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.isCountContainer = false,
    this.count,
    this.imageColor,
    this.textColor,
    this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10,vertical: verticalPadding ?? 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: backgroundColor ?? AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if(isCountContainer == true)...[
              SvgPicture.asset(image ?? "", colorFilter:  ColorFilter.mode(
                imageColor ?? AppColors.darkGrey,
                BlendMode.srcIn,
              ), height: 14),
              const Gap(5),
              Text("$text ",style: AppTextStyles.style10Black400,),
              Text(count ?? "",style: AppTextStyles.style10Black500,),
            ]else...[
              SvgPicture.asset(image ?? "", colorFilter: ColorFilter.mode(
                imageColor ?? AppColors.darkGrey,
                BlendMode.srcIn,
              ),height: 16),
              const Gap(5),
              Text(text ?? "",
                style: TextStyle(
                  color: textColor ?? AppColors.darkGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                   //AppTextStyles.style10Black400
                ),
              ),
            ],


          ],
        ),
      ),
    );
  }
}
