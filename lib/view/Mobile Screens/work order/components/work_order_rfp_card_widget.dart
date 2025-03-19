import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/icon_text_container_widget.dart';
import '../../../widgets/logout_widget.dart';
import '../../../widgets/status_widget.dart';

class WorkOrderDashboardCardWidget extends StatelessWidget {
  final String? boxImage;
  final String? title;
  final String? name;
  final String? vendorName;
  final String? date;
  final String? status;
  final String? reference;
  final VoidCallback? logoutOnPressed;
  const WorkOrderDashboardCardWidget({super.key,
    this.boxImage,
    this.title,
    this.name,
    this.status,
    this.vendorName,
    this.date,
    this.reference,
    this.logoutOnPressed
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              width: 65,
              height: 65,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: AppColors.pearlGray,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  const Gap(15),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      boxImage ?? "",
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const Gap(2),
                  Expanded(child: Text(name ?? "",style: AppTextStyles.style8Primary500,textAlign: TextAlign.center,
                    maxLines: 2,)),
                ],
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
                    StatusWidget(status: status ?? "--",
                      dotColor: AppColors.green,
                      statusColor: AppColors.green,
                      backgroundColor: AppColors.green.withAlpha(20),
                    ),
                  ],
                ),
                const Gap(5),
                Text(reference ?? "",style: AppTextStyles.style10Grey400,),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconTextContainerWidget(
                          image: AppImages.vendor,
                          text: vendorName ?? "",
                          backgroundColor: AppColors.pearlGray,
                          verticalPadding: 3,
                          horizontalPadding: 4,
                        ),
                        const Gap(5),
                        IconTextContainerWidget(
                          image: AppImages.date,
                          text: date ?? "",
                          backgroundColor: AppColors.pearlGray,
                          verticalPadding: 3,
                          horizontalPadding: 4,
                        ),
                      ],
                    ),
                     LogoutWidget(
                      onPressed: logoutOnPressed,
                      backgroundColor:  AppColors.red ,
                      image: AppImages.logout,
                    ),
                  ],
                ),
                const Gap(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
