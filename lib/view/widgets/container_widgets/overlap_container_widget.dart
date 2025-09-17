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
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: backgroundColor ?? AppColors.primary),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
              Flexible(
                child: Text(
                  text ?? "",
                  style: TextStyle(
                    fontSize: AppUtils.isTablet(context) ? 15 : 13,
                    fontWeight: FontWeight.w500,
                    color: textColor ?? AppColors.white,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
