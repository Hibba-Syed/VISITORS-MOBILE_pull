import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';

import '../../../resource/constants/app_constants.dart';
class StackCountContainerWidget extends StatelessWidget {
  final String? imageUrl;
  final double?  imageHeight;
  final double?  imageWidth;
  final double?  countTopPositioned;
  final double?  countRightPositioned;
  final double?  countPadding;
  final Color?   backgroundColor;
  final int? count;
  const StackCountContainerWidget({super.key,
    this.imageHeight,
    this.imageUrl,
    this.imageWidth,
    this.count,
    this.countTopPositioned,
    this.countRightPositioned,
    this.countPadding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double countPadding = (count != null && count! % 2 == 0) ? 3.0 : 5.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
         NetworkImageWidget(
            height: imageHeight ?? 90,
            width: imageWidth ?? 90,
            url: imageUrl ?? ""),
        Positioned(
          top: countTopPositioned ?? -1,
          right: countRightPositioned ?? -1,
          child: Container(
            padding:  EdgeInsets.all(countPadding),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor ?? AppColors.primary,
                border: Border.all(
                    color: AppColors.white, width: 2)),
            child:  Text(
              count?.toString() ?? "",
              style:  AppConstants.isMobile(context) ? AppTextStyles.style12white400 : AppTextStyles.style13white400,
            ),
          ),
        ),
      ],
    );
  }
}
