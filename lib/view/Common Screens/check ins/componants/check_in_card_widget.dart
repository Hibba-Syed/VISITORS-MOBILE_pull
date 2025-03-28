import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/icon_title_value_container_widget.dart' show IconTitleValueContainerWidget;

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
  final String? unit;

  final VoidCallback? logoutOnPressed;
  const CheckInCardWidget(
      {super.key,
      this.profileImageUrl,
      this.name,
      this.type,
      this.phone,
      this.unit,
      this.date,
      this.gateValue,
      this.logoutOnPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
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
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gray,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                profileImageUrl ?? "",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return
                                    Container(
                                    color: AppColors.gray,
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -6,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue,
                                    border: Border.all(
                                        color: AppColors.white, width: 4)),
                                child: const Text(
                                  '5',
                                  style: AppTextStyles.style12white600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(3),
                      Text(
                        type ?? "",
                        style: AppTextStyles.style12darkGrey500,
                      ),
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
                        Row(
                          children: [
                            IconTextContainerWidget(
                              image: AppImages.date,
                              text: date ?? "",
                            ),
                            const Gap(5),
                            IconTextContainerWidget(
                              image: AppImages.phone,
                              text: phone ?? "",
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
                onPressed: logoutOnPressed,
                image: AppImages.logout,
                backgroundColor: AppColors.red,
              ),
            ],
          ),
        ),
        Positioned(
          top: -32,
          child: Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                color: AppColors.blue),
            child: Text(
              unit ?? "Mughal-1024",
              style: AppTextStyles.style12white500,
            ),
          ),
        ),
      ],
    );
  }
}
