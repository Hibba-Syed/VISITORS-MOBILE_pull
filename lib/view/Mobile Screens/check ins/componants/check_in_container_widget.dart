import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/button/action_button.dart';
import 'package:visitors/view/widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/logout_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';

class CheckInCardWidget extends StatelessWidget {
  final String? boxImage;
  final String? name;
  final String? type;
  final String? boxText;
  final String? visitorCount;
  final String? date;
  final String? gate;
  final VoidCallback? logoutOnPressed;
  const CheckInCardWidget(
      {super.key,
      this.boxImage,
      this.name,
      this.boxText,
      this.type,
      this.visitorCount,
      this.date,
        this.gate,
        this.logoutOnPressed
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
              color: AppColors.pearlGray,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(
                    boxImage ?? "",
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
                  boxText ?? "",
                  style: AppTextStyles.style14Black600,
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
                  name ?? "",
                  style: AppTextStyles.style14Black600,
                ),
                const Gap(5),
                Text(
                  type ?? "",
                  style: AppTextStyles.style12darkGrey400,
                ),
                const Gap(2),
                Row(
                  children: [
                    IconTextContainerWidget(
                      image: AppImages.date,
                      text: date ?? "",
                      backgroundColor: AppColors.pearlGray,
                      verticalPadding: 4,
                      horizontalPadding: 6,
                    ),
                    const Gap(5),
                    IconTextContainerWidget(
                      isCountContainer: true,
                      image: AppImages.count ,
                      text: visitorCount ?? "",
                      backgroundColor: AppColors.pearlGray,
                      verticalPadding: 4,
                      horizontalPadding: 6,
                    ),

                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextContainerWidget(
                      image: AppImages.gate,
                      text: gate ?? "",
                      backgroundColor: AppColors.pearlGray,
                      verticalPadding: 4,
                      horizontalPadding: 6,
                    ),
                    LogoutWidget(
                      onPressed: logoutOnPressed,
                      image: AppImages.logout,
                      backgroundColor: AppColors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
