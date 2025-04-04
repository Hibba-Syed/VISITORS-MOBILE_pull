import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart'
    show IconTitleValueContainerWidget;
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';

class VisitorPassesCardWidget extends StatelessWidget {
  final String? reference;
  final String? unit;
  final String? name;
  final String? company;
  final String? fromDate;
  final String? phone;
  final String? email;
  final String? profileImageUrl;
  final VoidCallback? checkInOnPressed;
  final VoidCallback? serviceableOnPressed;

  const VisitorPassesCardWidget(
      {super.key,
        this.unit,
        this.reference,
        this.name,
        this.fromDate,
        this.phone,
        this.email,
        this.company,
        this.profileImageUrl,
        this.checkInOnPressed,
        this.serviceableOnPressed,
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
              text: unit,
                     ),
             OverlapContainerWidget(
              text: reference,
               backgroundColor: AppColors.yellow),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      NetworkImageWidget(url: profileImageUrl,),
                    ],
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? "",
                          style: AppTextStyles.style14Black600,
                        ),
                        const Gap(6),
                        IconTitleValueContainerWidget(
                          title: 'From',
                          value: fromDate,
                          image: AppImages.date,
                        ),
                        const Gap(5),
                        IconTextContainerWidget(
                          image: AppImages.phone,
                          text: phone ?? "",
                        ),
                        const Gap(5),
                        IconTextContainerWidget(
                          icon: Icons.email_outlined,
                          iconColor: AppColors.darkGrey,
                          text: email,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(5),
               Row(
                children: [
                  const Text('Company: ',style: AppTextStyles.style14Black600,),
                  Text( company ?? "",style: AppTextStyles.style14DarkGrey400,),
                ],
              ),
              const Gap(10),
              LogoutButton(
                text: 'Check-In',
                onPressed: checkInOnPressed,
                backgroundColor: AppColors.green,
                image: AppImages.checkInButton,
              ),
              const Gap(8),
              LogoutButton(
                text: 'Serviceable Check - Ins',
                onPressed: serviceableOnPressed,
                backgroundColor: AppColors.cyanBlue,
                image: AppImages.serviceable,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
