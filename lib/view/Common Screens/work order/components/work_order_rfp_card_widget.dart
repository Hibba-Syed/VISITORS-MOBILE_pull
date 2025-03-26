import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/button/logout_button.dart';
import '../../../widgets/status/status_widget.dart';

class WorkOrderRFPCardWidget extends StatelessWidget {
  final String? title;
  final String? vendorName;
  final String? date;
  final String? status;
  final String? reference;
  final VoidCallback? logoutOnPressed;
  const WorkOrderRFPCardWidget({super.key,
    this.title,
    this.status,
    this.vendorName,
    this.date,
    this.reference,
    this.logoutOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.workOrderJobDetailsScreen);
      },
      child: Container(
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
                Text(
                  title ?? "",
                  style: AppTextStyles.style14Black600,
                ),
                StatusWidget(status: status ?? "",
                ),
              ],
            ),
            const Gap(5),
            Text(reference ?? "",style: AppTextStyles.style12darkGrey500,),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                    width: 65,
                    height: 65,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        const Gap(15),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            AppImages.hammer,
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const Gap(2),
                        const Expanded(child: Text("Work Order",style: AppTextStyles.style8Primary500,textAlign: TextAlign.center,
                          maxLines: 2,)),
                      ],
                    ),
                  ),
                  const Gap(5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTextContainerWidget(
                      image: AppImages.vendor,
                      text: vendorName ?? "",

                    ),
                    const Gap(5),
                    IconTextContainerWidget(
                      image: AppImages.date,
                      text: date ?? "",
                    ),
                  ],
                ),

              ],
            ),
            const Gap(10),
            LogoutButton(
              text: 'Check - In',
              onPressed: logoutOnPressed,
              backgroundColor:  AppColors.green ,
              image: AppImages.checkInButton,
            ),
          ],
        ),
      ),
    );
  }
}
