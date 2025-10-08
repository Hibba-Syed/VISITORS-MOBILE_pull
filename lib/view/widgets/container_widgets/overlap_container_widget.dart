import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';

class OverlapContainerWidget extends StatelessWidget {
  final String? text;
  final Color? color;
  final String? svgImagePath;
  const OverlapContainerWidget({
    super.key,
    this.text,
    this.color,
    this.svgImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color != null
              ? color!.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgImagePath != null && svgImagePath!.isNotEmpty) ...[
              SvgPicture.asset(
                svgImagePath ?? "",
                height: 12,
                width: 12,
                colorFilter: ColorFilter.mode(
                  color ?? AppColors.primary,
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
                      color: color ?? AppColors.primary,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
