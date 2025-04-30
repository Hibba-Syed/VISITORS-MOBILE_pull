import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/status/status_widget.dart';
import 'package:visitors/utils/app_utils.dart';


class WorkOrderRFPCardWidget extends StatelessWidget {
  final String? title;
  final String? vendorName;
  final String? date;
  final String? status;
  final String? reference;
  final String? typeText;
  final String? typeAssetImage;
  final VoidCallback checkInPressed;
  final VoidCallback detailsOnPressed;
  final VoidCallback jobCheckInOnPressed;
  const WorkOrderRFPCardWidget({
    super.key,
    this.title,
    this.status,
    this.vendorName,
    this.date,
    this.reference,
    this.typeText,
    required this.checkInPressed,
    required this.detailsOnPressed,
    this.typeAssetImage,
    required this.jobCheckInOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OverlapContainerWidget(
              text: typeText,
              image: typeAssetImage,
            ),
            OverlapContainerWidget(
              text: reference,
            ),
          ],
        ),
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: detailsOnPressed,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? "",
                      style: AppUtils.isTablet(context) ? AppTextStyles.style16black600 : AppTextStyles.style15Black600,
                    ),
                    StatusWidget(
                      status: status ?? "",
                    ),
                  ],
                ),
                const Gap(5),
                IconTextContainerWidget(
                  image: AppImages.vendor,
                  text: vendorName ?? "",
                ),
                const Gap(5),
                IconTextContainerWidget(
                  image: AppImages.date,
                  text: DateTimeUtil.getFormattedDateTime(date),
                ),
                const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              height: AppUtils.isTablet(context) ? 55 : 42,
                              fontSize: AppUtils.isTablet(context)  ? 20 : 15,
                              imageHeight: AppUtils.isTablet(context) ?25 :18,
                              buttonColor: AppColors.green,
                              image: AppImages.checkInButton,
                              text: 'Check-In',
                              onPressed: checkInPressed),
                        ),
                        const Gap(8),
                        Expanded(
                          child: CustomButton(
                              height:  AppUtils.isTablet(context)  ? 55 : 42,
                              fontSize: AppUtils.isTablet(context)  ? 20 : 15,
                              imageHeight: AppUtils.isTablet(context) ?25 :18,
                              buttonColor: AppColors.cyanBlue,
                              image: AppImages.serviceable,
                              text: 'Job Check - Ins', onPressed: jobCheckInOnPressed
                          ),
                        ),
                      ],
                    )

              ],
            ),
          ),
        ),
      ],
    );
  }
}
