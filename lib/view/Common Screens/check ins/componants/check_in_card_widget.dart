import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart' show IconTitleValueContainerWidget;
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';

class CheckInCardWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? name;
  final String? gateValue;
  final String? type;
  final String? phone;
  final String? date;
  final int? count;
  final String? typeText;
  final String? typeImage;
  final String? reference;
  final VoidCallback? checkOutOnPressed;
  const CheckInCardWidget(
      {super.key,
      this.profileImageUrl,
      this.name,
      this.type,
      this.phone,
      this.typeText,
      this.date,
      this.gateValue,
        this.typeImage,
        this.reference,
        this.count,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            NetworkImageWidget(url: profileImageUrl,),
                            Positioned(
                              top: -5,
                              right: -6,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue,
                                    border: Border.all(
                                        color: AppColors.white, width: 2)),
                                child:  Text(
                                  count?.toString() ?? "",
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
                        Row(
                          children: [
                            Expanded(
                              child: IconTextContainerWidget(
                                image: AppImages.date,
                                text: date ?? "",
                              ),
                            ),
                            const Gap(5),
                            Expanded(
                              child: IconTextContainerWidget(
                                image: AppImages.phone,
                                text: phone ?? "",
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        IconTitleValueContainerWidget(
                          image: AppImages.gate,
                          title:  'Gate',
                          value: gateValue ?? "",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(10),
              LogoutButton(
                text: 'Check Out',
                onPressed: checkOutOnPressed,
                image: AppImages.logout,
                backgroundColor: AppColors.red,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
