import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';


class ReferenceContainerWidget extends StatelessWidget {
  final String? text;
  final String? svg;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? imageColor;
  final double? width;
  final FontWeight? fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final int? maxLines;
  final double? maxContainerWidth;
  final Widget? widgetOnFrontOfReference;
  final double iconSize;
  const ReferenceContainerWidget({
    super.key,
    this.text,
    this.bgColor,
    this.textColor,
    this.imageColor,
    this.borderColor,
    this.width,
    this.fontWeight,
    this.horizontalPadding,
    this.verticalPadding,
    this.svg,
    this.maxLines,
    this.maxContainerWidth,
    this.iconSize = 13,
    this.widgetOnFrontOfReference
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox( 
      constraints: BoxConstraints(
        maxWidth: maxContainerWidth??double.infinity,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 5, horizontal: horizontalPadding ?? 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: bgColor ?? AppColors.referenceColor,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                   svg ?? "",
                    height: 13,
                    width: 13,
                    colorFilter:  const ColorFilter.mode(
                     AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(2),
                ],
              ),
              Flexible(
                child: Text(text ?? "",
                  style: AppTextStyles.styleReferencePrimaryColor400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
