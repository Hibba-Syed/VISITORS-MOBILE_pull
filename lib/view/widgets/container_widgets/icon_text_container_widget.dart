import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/styles/styles.dart';

class IconTextContainerWidget extends StatelessWidget {
  final String? text;
  final String? image;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? imageColor;
  final IconData? icon;
  final Color? iconColor;

  const IconTextContainerWidget({super.key,
    this.text,
    this.image,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.imageColor,
    this.textColor,
    this.icon,
    this.iconColor

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 8,vertical: verticalPadding ?? 6),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(5),
        color: backgroundColor ?? AppColors.gray,
      ),
      child: Row(
       // mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null)
            Row(
              children: [
                SvgPicture.asset(image ?? "",
                  height: 16,
                  colorFilter: ColorFilter.mode(
                  imageColor ?? AppColors.darkGrey,
                  BlendMode.srcIn,
                ),),
                const Gap(3),
              ],
            )
          else if (icon != null)
            Row(
              children: [
                Icon(
                  icon,
                  color: iconColor ?? AppColors.primary,
                  size: 17,
                ),
                const Gap(3),
              ],
            )
          else
            const SizedBox.shrink(),
          const Gap(2),
            Flexible(
              child: Text( text ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor ?? AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                   //AppTextStyles.style10Black400
                ),
              ),
            ),
        ],
      ),
    );
  }
}
