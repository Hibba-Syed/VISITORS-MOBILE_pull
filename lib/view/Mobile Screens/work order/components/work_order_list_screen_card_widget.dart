import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/container_widget/icon_text_container_widget.dart';
import '../../../widgets/button/logout_button.dart';
import '../../../widgets/reference/reference_widget.dart';
import '../../../widgets/status/status_widget.dart';

class WorkOrderListScreenCardWidget extends StatelessWidget {
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
  final bool isWorkOderDashBoardScreen;
  const WorkOrderListScreenCardWidget({super.key,
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
    this.isWorkOderDashBoardScreen = false,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReferenceWidget(
                text: reference,
                svg: AppImages.link,
              ),
              StatusWidget(status: status ?? "--",
                dotColor: AppColors.green,
                statusColor: AppColors.green,
                backgroundColor: AppColors.green.withAlpha(20),
              ),
            ],
          ),
          const Gap(5),
          Text(title ?? "",style: AppTextStyles.style14Black600,),
          const Gap(5),
          Text(secondTitle ?? "",style: AppTextStyles.style12darkGrey400,),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconTextContainerWidget(
                    image: containerImage1 ?? "",
                    text: containerText1 ?? "",
                    backgroundColor: AppColors.gray,
                    verticalPadding: 3,
                    horizontalPadding: 4,
                  ),
                  const Gap(5),
                  IconTextContainerWidget(
                    image: containerImage2 ?? "" ,
                    text: containerText2 ?? "",
                    backgroundColor: AppColors.gray,
                    verticalPadding: 3,
                    horizontalPadding: 4,
                  ),
                ],
              ),
              const LogoutButton(
                backgroundColor:  AppColors.green ,
                image: AppImages.logout,
              ),
            ],
          ),
          const Gap(5),

        ],
      ),
    );
  }
}
