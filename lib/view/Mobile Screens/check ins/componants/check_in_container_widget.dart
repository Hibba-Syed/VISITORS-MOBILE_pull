import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';

class CheckInContainerWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? secondTitle;
  final String? count;
  // final String? containerImage1;
  final String? containerText1;
  // final String? containerImage2;
  // final String? containerText2;
  // final String? containerImage3;
  // final String? containerText3;
  final Widget? widget;
  final Widget? mobileWidget;
  const CheckInContainerWidget(
      {super.key,
      this.image,
      this.title,
      this.count,
      this.secondTitle,
      // this.containerImage1,
      this.containerText1,
      // this.containerImage2,
      // this.containerText2,
      // this.containerImage3,
      // this.containerText3,
        this.widget,
        this.mobileWidget,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 65,
            height: 65,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey1,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(
                    image ?? "",
                    width: 19,
                    height: 19,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const Gap(2),
                Text(
                  count ?? "",
                  style: AppTextStyles.style12Black500,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                )
              ],
            ),
          ),
          const Gap(5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: AppTextStyles.style12Black500,
                ),
                const Gap(2),
                Text(
                  secondTitle ?? "",
                  style: AppTextStyles.style10Grey400,
                ),
                const Gap(2),
                widget ?? SizedBox.shrink(),
                // Row(
                //   children: [
                //     IconTextContainerWidget(
                //       image: containerImage1 ?? "",
                //       text: containerText1 ?? "",
                //       containerColor: AppColors.lightGrey1,
                //       verticalPadding: 4,
                //       horizontalPadding: 6,
                //       isTextColor: true,
                //     ),
                //     const Gap(5),
                //     IconTextContainerWidget(
                //       isCountContainer: true,
                //       image: containerImage2 ?? "" ,
                //       text: containerText2 ?? "",
                //       containerColor: AppColors.lightGrey1,
                //       verticalPadding: 4,
                //       horizontalPadding: 6,
                //       isTextColor: true,
                //     ),
                //
                //
                //   ],
                // ),
                const Gap(5),
                mobileWidget ?? SizedBox.shrink(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     IconTextContainerWidget(
                //       isCountContainer: true,
                //       image: containerImage3 ?? "",
                //       text: containerText3 ?? "",
                //       containerColor: AppColors.lightGrey1,
                //       verticalPadding: 4,
                //       horizontalPadding: 6,
                //       isTextColor: true,
                //     ),
                //     Flexible(
                //       child: IconContainerWidget(
                //         image: AppImages.logout,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
