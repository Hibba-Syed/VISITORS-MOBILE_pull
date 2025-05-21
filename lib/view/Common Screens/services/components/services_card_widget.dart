import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/utils/app_utils.dart';

class ServicesCardWidget extends StatelessWidget {
  final String? title;
  final String? reference;
  final String? unit;
  final String? status;
  final String? name;
  final String? serviceType;
  final VoidCallback checkInOnPressed;
  final VoidCallback serviceableCheckInOnPressed;
  final VoidCallback detailsOnPressed;
  final bool isActiveCheckins;
  const ServicesCardWidget({
    super.key,
    this.title,
    this.unit,
    this.reference,
    this.status,
    this.name,
    this.serviceType,
    required this.checkInOnPressed,
    required this.serviceableCheckInOnPressed,
    required this.detailsOnPressed,
    this.isActiveCheckins = false,
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
              text: unit ?? "",
            ),
            OverlapContainerWidget(
              text: reference ?? "",
            ),
          ],
        ),
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: detailsOnPressed,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
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
                      style: AppUtils.isTablet(context)
                          ? AppTextStyles.style15Black600
                          : AppTextStyles.style14Black600,
                    ),
                    status?.isNotEmpty ?? true
                        ? StatusWidget(
                            status: status ?? "",
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Expanded(
                      child: IconTextContainerWidget(
                        image: AppImages.services,
                        text: serviceType ?? "",
                      ),
                    ),
                    const Gap(5),
                    Expanded(
                      child: IconTextContainerWidget(
                        image: AppImages.person,
                        text: name ?? "",
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          height: AppUtils.isTablet(context) ? 55 : 42,
                          fontSize: AppUtils.isTablet(context) ? 20 : 15,
                          imageHeight: AppUtils.isTablet(context) ? 25 : 18,
                          buttonColor: AppColors.green,
                          image: AppImages.checkInButton,
                          text: 'Check-In',
                          onPressed: checkInOnPressed),
                    ),
                    if(isActiveCheckins)...[
                      const Gap(8),
                      Expanded(
                        child: CustomButton(
                            height: AppUtils.isTablet(context) ? 55 : 42,
                            fontSize: AppUtils.isTablet(context) ? 20 : 15,
                            imageHeight: AppUtils.isTablet(context) ? 25 : 18,
                            buttonColor: AppColors.cyanBlue,
                            image: AppImages.serviceable,
                            text: 'Serviceable Check Ins',
                            onPressed: serviceableCheckInOnPressed),
                      ),
                    ],

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
