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
    //final int? parsedCount = int.tryParse(count ?? "");
  //  final double countPadding = (parsedCount != null && parsedCount % 2 == 0) ? 3 : 5;
    return Stack(
      clipBehavior: Clip.none,
      children: [
         NetworkImageWidget(
            height: imageHeight ?? 80,
            width: imageWidth ?? 80,
            url: imageUrl ?? "",
           imageBackgroundColor:  imageBackgroundColor ?? AppColors.gray,

         ),
        Positioned(
          top: countTopPositioned ?? -1,
          right: countRightPositioned ?? -1,
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: 20,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor ?? AppColors.primary,
                border: Border.all(
                    color: AppColors.white, width: 2
                )),
            child:  Text(
              textAlign: TextAlign.center,
              count?.toString() ?? "",
              style:  AppUtils.isMobile(context) ?
              AppTextStyles.style11white400
                  :
              AppTextStyles.style14white400,
            ),
          ),
        ),
      ],
    );
  }
}
