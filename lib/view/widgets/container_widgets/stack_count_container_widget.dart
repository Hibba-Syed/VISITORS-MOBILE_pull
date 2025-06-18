import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';
import 'package:visitors/utils/app_utils.dart';
class StackCountContainerWidget extends StatelessWidget {
  final String? imageUrl;
  final double?  imageHeight;
  final double?  imageWidth;
  final double?  countTopPositioned;
  final double?  countRightPositioned;
  final double?  countPadding;
  final Color?   backgroundColor;
  final Color?   imageBackgroundColor;
  final String? count;
  const StackCountContainerWidget({super.key,
    this.imageHeight,
    this.imageUrl,
    this.imageWidth,
    this.count,
    this.countTopPositioned,
    this.countRightPositioned,
    this.countPadding,
    this.backgroundColor,
    this.imageBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final int? parsedCount = int.tryParse(count ?? "");
    final double countPadding = (parsedCount != null && parsedCount % 2 == 0) ? 4 : 5;
    return Stack(
      clipBehavior: Clip.none,
      children: [
         NetworkImageWidget(
            height: imageHeight ?? 90,
            width: imageWidth ?? 90,
            url: imageUrl ?? "",
           imageBackgroundColor:  imageBackgroundColor ?? AppColors.gray,

         ),
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
              style:  AppUtils.isMobile(context) ? AppTextStyles.style12white400 : AppTextStyles.style13white400,
            ),
          ),
        ),
      ],
    );
  }
}
