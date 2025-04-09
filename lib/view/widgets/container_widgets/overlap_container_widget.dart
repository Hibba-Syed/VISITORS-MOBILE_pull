import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
class OverlapContainerWidget extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final String? image;
  const OverlapContainerWidget({
    super.key,
    this.text,
    this.backgroundColor,
    this.image,

  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6),
                topLeft: Radius.circular(6),
              ),
              color: backgroundColor ?? AppColors.blue),
          child: Row(
            children: [
          if (image != null && image!.isNotEmpty) ...[
          SvgPicture.asset(
                image ?? "",
                height: 13,
                width: 13,
                colorFilter:  const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(3),
          ],
              Text(
                text ?? "",
                style: AppTextStyles.style13white500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
