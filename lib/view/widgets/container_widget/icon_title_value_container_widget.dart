import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/styles/styles.dart';

class IconTitleValueContainerWidget extends StatelessWidget {
  final String? value;
  final String? image;
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? imageColor;
  final VoidCallback? onPressed;

  const IconTitleValueContainerWidget({super.key,
    this.value,
    this.image,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.imageColor,
    this.textColor,
    this.onPressed,
    this.title,

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
          mainAxisSize: MainAxisSize.min,
          children: [
              SvgPicture.asset(image ?? "", colorFilter:  ColorFilter.mode(
                imageColor ?? AppColors.darkGrey,
                BlendMode.srcIn,
              ), height: 14),
              const Gap(5),
              Text("$title: ",style: AppTextStyles.style12Black500,),
              Text( value?? "",style: AppTextStyles.style12Black400,),

          ],
        ),
      ),
    );
  }
}
