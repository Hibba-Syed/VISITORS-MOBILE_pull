import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart' show IconTitleValueContainerWidget;
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/stack_count_container_widget.dart';
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
  final VoidCallback checkOutOnPressed;
  final VoidCallback detailsOnPressed;
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
     required this.checkOutOnPressed,
     required this.detailsOnPressed,
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
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: detailsOnPressed,
          child: Container(
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
                         StackCountContainerWidget(
                           imageHeight: 55,
                          imageWidth: 55,
                          count: count,
                          countPadding: 6,
                          countTopPositioned: -5,
                          countRightPositioned: -6,
                           backgroundColor: AppColors.blue,
                          imageUrl: profileImageUrl,
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
                CustomButton(
                    image: AppImages.logout,
                    buttonColor: AppColors.red,
                    text: 'Check Out', onPressed: checkOutOnPressed),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
