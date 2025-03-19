import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/icon_text_widget.dart';
import '../../../widgets/logout_widget.dart';
import '../../../widgets/status_widget.dart';

class WorkOrderDashboardCardWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? secondTitle;
  final String? name;
  final String? containerImage1;
  final String? containerText1;
  final String? containerImage2;
  final String? containerText2;
  final String? status;
  final String? reference;
  const WorkOrderDashboardCardWidget({super.key,
    this.image,
    this.title,
    this.name,
    this.status,
    this.secondTitle,
    this.containerImage1,
    this.containerText1,
    this.containerImage2,
    this.containerText2,
    this.reference,
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
                color: AppColors.lightGrey1,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  const Gap(15),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      image ?? "",
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
                      containerColor: AppColors.green.withAlpha(20),
                    ),
                  ],
                ),
                const Gap(5),
                Text(secondTitle ?? "",style: AppTextStyles.style10Grey400,),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconTextWidget(
                          image: containerImage1 ?? "",
                          text: containerText1 ?? "",
                          containerColor: AppColors.lightGrey1,
                          verticalPadding: 3,
                          horizontalPadding: 4,
                          isTextColor: true,
                        ),
                        const Gap(5),
                        IconTextWidget(
                          image: containerImage2 ?? "" ,
                          text: containerText2 ?? "",
                          containerColor: AppColors.lightGrey1,
                          verticalPadding: 3,
                          horizontalPadding: 4,
                          isTextColor: true,
                        ),
                      ],
                    ),
                    const LogoutWidget(
                      containerColor:  AppColors.red ,
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
// ReferenceContainerWidget(
// text: reference,
// svg: AppImages.link,
// ),