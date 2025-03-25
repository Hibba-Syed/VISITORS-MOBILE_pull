import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart' show IconTitleValueContainerWidget;

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/status/status_widget.dart';

class ServicesCardWidget extends StatelessWidget {
  final String? title;
  final String? reference;
  final String? unit;
  final String? status;
  final String? name;
  final String? serviceType;
  final String? countValue;
  final VoidCallback? logoutOnPressed;

  const ServicesCardWidget({
    super.key,
    this.title,
    this.unit,
    this.reference,
    this.status,
    this.name,
    this.serviceType,
    this.countValue,
    this.logoutOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.servicesDetailsScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
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
                  status: status ?? "",
                ),
              ],
            ),
            const Gap(5),
            Text(
              reference ?? "",
              style: AppTextStyles.style12darkGrey500,
            ),
            const Gap(10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    unit ?? "",
                    style: AppTextStyles.style14Black600,
                  ),
                ),
                const Gap(6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconTextContainerWidget(
                            image: AppImages.services,
                            text: serviceType ?? "",
                            backgroundColor: AppColors.gray,
                          ),
                          const Gap(10),
                           IconTextContainerWidget(
                            image: AppImages.person,
                            text: name ?? "",
                            backgroundColor: AppColors.gray,
                           ),
                        ],
                      ),
                      const Gap(5),
                       IconTitleValueContainerWidget(
                        image: AppImages.count,
                        title:  "Check-In Count",
                        value: countValue ?? "",
                        backgroundColor: AppColors.gray,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            LogoutButton(
              text: 'Check-In',
              onPressed: logoutOnPressed,
              backgroundColor: AppColors.green,
              image: AppImages.checkInButton,
            ),
          ],
        ),
      ),
    );
  }
}
