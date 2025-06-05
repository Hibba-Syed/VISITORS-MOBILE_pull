import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../resource/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color? buttonColor;
  final String text;
  final String? image;
  final double? imageHeight;
  final Color? textColor;
  final TextAlign? textAlign;
  final double? borderRadius;
  final VoidCallback? onPressed;
  final int maxLines;
  final bool invert;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final FontWeight? fontWeight;
  final double fontSize;
  const CustomButton({
    super.key,
    this.buttonColor,
    required this.text,
    this.textAlign,
    this.width,
    this.image,
    this.height,
    this.fontSize = 15,
    this.maxLines = 1,
    this.padding = const EdgeInsets.all(10),
    this.textColor,
     this.onPressed,
    this.invert = false,
    this.fontWeight,
    this.borderRadius,
    this.imageHeight,
    // fontSize: AppUtils.isTablet(context)  ? 15 : 15,
    // imageHeight: AppUtils.isTablet(context) ?22 :18,
  });

  @override
  Widget build(BuildContext context) {
    final double bothHeight = height ?? (AppUtils.isTablet(context) ? 39 : 36);
    final double imageSize = imageHeight ?? (AppUtils.isTablet(context) ?22 :18);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        width: width,
        height: bothHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 7),
            border: invert == true
                ? Border.all(color: buttonColor ?? AppColors.primary, width: 1)
                : null,
            color: invert == true ? null : buttonColor ?? AppColors.primary),
        child: Row(
            mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              SvgPicture.asset(
                '$image',
                height: imageSize,
                //imageHeight ?? 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            if (image != null) AppUtils.isTablet(context) ? Gap(15) : Gap(10),
            // AutoSizeText(''),
            Flexible(
              child: Text(
                text,
                style: invert
                    ? TextStyle(
                        color: textColor ?? AppColors.primary,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      )
                    : TextStyle(
                        color: AppColors.white,
                        fontSize: fontSize,
                        fontWeight: fontWeight ?? FontWeight.w600,
                      ),
                textAlign: textAlign,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
