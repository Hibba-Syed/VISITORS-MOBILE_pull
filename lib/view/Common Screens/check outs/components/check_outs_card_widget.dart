import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart' show IconTitleValueContainerWidget;
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/stack_count_container_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';


class CheckOutsCardWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? name;
  final String? visitorCount;
  final String? checkInGateValue;
  final String? checkOutGateValue;
  final Color? typeBackgroundColor;
  final String? type;
  final String? phone;
  final String? checkInDate;
  final String? checkOutDate;
  final String? typeText;
  final String? typeImage;
  final VoidCallback? checkOutOnPressed;
  const CheckOutsCardWidget(
      {super.key,
        this.profileImageUrl,
        this.visitorCount,
        this.name,
        this.type,
        this.phone,
        this.typeText,
        this.checkInDate,
        this.checkOutDate,
        this.checkInGateValue,
        this.checkOutGateValue,
        this.typeImage,
        this.typeBackgroundColor,
        this.checkOutOnPressed
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
              image: typeImage,
              backgroundColor: AppColors.primary,
            ),
            OverlapContainerWidget(
              text: type,
              backgroundColor: typeBackgroundColor ?? AppColors.yellow,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      StackCountContainerWidget(
                        imageHeight: 55,
                        imageWidth: 55,
                        count: visitorCount,
                        countPadding: 4 ,
                        countTopPositioned: -10,
                        countRightPositioned: -6,
                        imageUrl: profileImageUrl,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? "",
                          style: AppUtils.isTablet(context) ?  AppTextStyles.style16black600 : AppTextStyles.style14Black600,
                        ),
                        const Gap(6),
                        IconTextContainerWidget(
                          image: AppImages.phone,
                          text: phone ?? "",
                        ),
                        const Gap(5),
                         Text('Check-In',style: AppUtils.isTablet(context) ? AppTextStyles.style15Black600 : AppTextStyles.style14Black600 ),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: IconTextContainerWidget(
                                image: AppImages.date,
                                text: checkInDate ?? "",
                              ),
                            ),
                            const Gap(5),
                            Expanded(
                              child: IconTitleValueContainerWidget(
                                image: AppImages.gate,
                                title:  'Gate',
                                value: checkInGateValue ?? "",
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                         Text('Check-Out',style: AppUtils.isTablet(context) ?AppTextStyles.style15Black600 :  AppTextStyles.style14Black600,),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: IconTextContainerWidget(
                                image: AppImages.date,
                                text: checkOutDate ?? "",
                              ),
                            ),
                            const Gap(5),
                            Expanded(
                              child: IconTitleValueContainerWidget(
                                image: AppImages.gate,
                                title:  'Gate',
                                value: checkOutGateValue ?? "",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ],
    );
  }
}
