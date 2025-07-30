import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
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
            typeText?.isNotEmpty ?? true ?
            OverlapContainerWidget(
              text: typeText,
              image: typeImage,
              backgroundColor: AppColors.primary,
            ) : SizedBox.shrink(),
            OverlapContainerWidget(
              text: type,
              backgroundColor: AppUtils.getCheckOutTypeColor(type),
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
                          style: AppUtils.isTablet(context) ?  AppTextStyles.style16black600 : AppTextStyles.style15Black600,
                        ),
                        const Gap(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppUtils.languageTranslate('checkIn'),style: AppUtils.isTablet(context) ? AppTextStyles.style14Black600 : AppTextStyles.style13Black600 ),
                                  const Gap(5),
                                  IconTextContainerWidget(
                                    image: AppImages.date,
                                    text: checkInDate ?? "",
                                  ),
                                ],
                              ),
                            ),
                            const Gap(5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(AppUtils.languageTranslate('checkOut'),style: AppUtils.isTablet(context) ?AppTextStyles.style14Black600 :  AppTextStyles.style13Black600,),
                                  IconTextContainerWidget(
                                    image: AppImages.date,
                                    text: checkOutDate ?? "",
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
              ),
            ],
          ),
        ),

      ],
    );
  }
}
