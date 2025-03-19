import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../resource/constants/app_colors.dart';
import '../../resource/styles/styles.dart';

class IconTextWidget extends StatelessWidget {
  final String? text;
  final String? image;
  final Color? containerColor;
  final bool? isTextColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String? count;
  final bool? isCountContainer;
  final Color? imageColor;
  final VoidCallback? onPressed;
  const IconTextWidget({super.key,
    this.text,
    this.image,
    this.containerColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.isCountContainer = false,
    this.count,
    this.imageColor,
    this.isTextColor = false,
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
          color: containerColor ?? AppColors.primary,
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
              Text(text ?? "",style: isTextColor == true ? AppTextStyles.style10Black400 : AppTextStyles.style12white500,),
            ],


          ],
        ),
      ),
    );
  }
}
