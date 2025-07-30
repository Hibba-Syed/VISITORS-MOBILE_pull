import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart' show ReadMoreText, TrimMode;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';

class ReadMoreWidget extends StatelessWidget {
  final String title;
  final String valueText;
  final FontWeight? fontWeight;
  final Color? fontColor;
  const ReadMoreWidget({
    super.key,
    required this.title,
    required this.valueText,
    this.fontWeight,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ",
          style: TextStyle(
              color: fontColor ?? AppColors.black,
              fontSize: AppUtils.isTablet(context) ?  15 : 13,
              fontWeight: fontWeight ?? FontWeight.w600),
        ),
        const Gap(8),
        ReadMoreText(
          valueText,
          textAlign: TextAlign.justify,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: AppUtils.languageTranslate('showLess'),
          trimCollapsedText: AppUtils.languageTranslate('showMore'),
          lessStyle: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
          ),
          moreStyle: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
          ),
          style:  TextStyle(
            fontSize:  AppUtils.isTablet(context) ? 15 : 13,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
