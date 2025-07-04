import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../resource/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color? buttonColor;
  final String? text;
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
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomButton({
    super.key,
    this.buttonColor,
    required this.text,
    this.textAlign,
    this.width,
    this.image,
    this.height,
    this.fontSize,
    this.maxLines = 1,
    this.textColor,
    this.onPressed,
    this.invert = false,
    this.fontWeight,
    this.borderRadius,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double bothHeight = height ?? (AppUtils.isTablet(context) ? 39 : 36);
    final double imageSize =
        imageHeight ?? (AppUtils.isTablet(context) ? 22 : 18);
    final double bothFontSize =
        fontSize ?? (AppUtils.isTablet(context) ? 15 : 12);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: bothHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
            if (image?.isNotEmpty ?? false) ...[
              SvgPicture.asset(
                image!,
                height: imageSize,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              AppUtils.isTablet(context) ? Gap(15) : Gap(10),
            ],
            Flexible(
              child: Text(
                text ?? "",
                style: invert
                    ? TextStyle(
                        color: textColor ?? AppColors.primary,
                        fontSize: bothFontSize,
                        fontWeight: FontWeight.w600,
                      )
                    : TextStyle(
                        color: AppColors.white,
                        fontSize: bothFontSize,
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
