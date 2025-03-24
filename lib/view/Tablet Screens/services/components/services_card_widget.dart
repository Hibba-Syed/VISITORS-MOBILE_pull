import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/view/widgets/container_widget/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/status/status_widget.dart';

class ServicesCardWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? reference;
  final String? count;
  final String? status;
  final String? name;
  final String? serviceType;
  final VoidCallback? logoutOnPressed;

  const ServicesCardWidget({
    super.key,
    this.image,
    this.title,
    this.count,
    this.reference,
    this.status,
    this.name,
    this.serviceType,
    this.logoutOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 65,
            height: 65,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              count ?? "",
              style: AppTextStyles.style14Black600,
            ),
          ),
          const Gap(5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? "",
                      style: AppTextStyles.style14Black600,
                    ),
                    StatusWidget(
                      status: status ?? "N/A",
                      dotColor: AppColors.green,
                      statusColor: AppColors.green,
                      backgroundColor: AppColors.green.withAlpha(20),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  reference ?? "",
                  style: AppTextStyles.style12darkGrey400,
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconTextContainerWidget(
                          image: AppImages.services,
                          text: serviceType ?? "",
                          backgroundColor: AppColors.gray,
                          verticalPadding: 4,
                          horizontalPadding: 6,
                        ),
                        const Gap(10),
                         IconTextContainerWidget(
                          image: AppImages.person,
                          text: name ?? "",
                          backgroundColor: AppColors.gray,
                          verticalPadding: 4,
                          horizontalPadding: 6,
                        ),
                      ],
                    ),
                     LogoutButton(
                      onPressed: logoutOnPressed,
                      backgroundColor: AppColors.green,
                      image: AppImages.logout,
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
