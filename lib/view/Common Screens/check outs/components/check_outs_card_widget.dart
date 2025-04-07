import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart' show IconTitleValueContainerWidget;
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';

class CheckOutsCardWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? name;
  final int? visitorCount;
  final String? checkInGateValue;
  final String? checkOutGateValue;
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
        this.checkOutOnPressed
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OverlapContainerWidget(
          text: typeText,
          image: typeImage,
          backgroundColor: AppColors.primary,
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
                           Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            NetworkImageWidget(url: profileImageUrl,),
                            Positioned(
                              top: -10,
                              right: -6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                    border: Border.all(
                                        color: AppColors.white, width: 2)),
                                child:  Text(
                                  visitorCount?.toString() ?? '',
                                  style: AppTextStyles.style12white400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const Gap(3),
                      Text(
                        type ?? "",
                        style: AppTextStyles.style12DarkGrey500,
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
                          style: AppTextStyles.style14Black600,
                        ),
                        const Gap(6),
                        IconTextContainerWidget(
                          image: AppImages.phone,
                          text: phone ?? "",
                        ),
                        const Gap(5),
                        const Text('Check-In',style: AppTextStyles.style13Black600,),
                        const Gap(5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              IconTextContainerWidget(
                                image: AppImages.date,
                                text: checkInDate ?? "",
                              ),
                              const Gap(5),
                              IconTitleValueContainerWidget(
                                image: AppImages.gate,
                                title:  'Gate',
                                value: checkInGateValue ?? "",
                              ),
                            ],
                          ),
                        ),
                        const Gap(5),
                        const Text('Check-Out',style: AppTextStyles.style13Black600,),
                        const Gap(5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              IconTextContainerWidget(
                                image: AppImages.date,
                                text: checkOutDate ?? "",
                              ),
                              const Gap(5),
                              IconTitleValueContainerWidget(
                                image: AppImages.gate,
                                title:  'Gate',
                                value: checkOutGateValue ?? "",
                              ),
                            ],
                          ),
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
