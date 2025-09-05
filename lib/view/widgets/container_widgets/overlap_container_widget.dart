import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';

class OverlapContainerWidget extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? imagedColor;
  final Color? textColor;
  final String? svgImagePath;
  const OverlapContainerWidget({
    super.key,
    this.text,
    this.backgroundColor,
    this.imagedColor,
    this.textColor,
    this.svgImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(6),
            topLeft: Radius.circular(6),
          ),
          color: backgroundColor ?? AppColors.primary),
      child: Row(
        children: [
          if (svgImagePath != null && svgImagePath!.isNotEmpty) ...[
            SvgPicture.asset(
              svgImagePath ?? "",
              height: 13,
              width: 13,
              colorFilter: ColorFilter.mode(
                imagedColor ?? AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            const Gap(3),
          ],
          if (text?.isNotEmpty ?? false)
            Text(text ?? "",
                style: AppUtils.isTablet(context)
                    ? TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? AppColors.white)

                    // AppTextStyles.style15white500
                    : TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? AppColors.white)
                // AppTextStyles.style13white500,
                ),
        ],
      ),
    );
  }
}
