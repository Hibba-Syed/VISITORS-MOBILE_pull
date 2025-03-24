
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/view/widgets/container_widget/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/container_widget/icon_title_value_container_widget.dart';

class CheckInCardWidget extends StatelessWidget {
  final String? profileImage;
  final String? valueImage;
  final String? name;
  final String? value;
  final String? type;
  final String? phone;
  final String? date;
  final String? gate;


  final VoidCallback? logoutOnPressed;
  const CheckInCardWidget(
      {super.key,
      this.profileImage,
        this.valueImage,
      this.name,
      this.type,
      this.phone,
      this.date,
        this.value,
        this.gate,
        this.logoutOnPressed
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
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
                            profileImage ?? "",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child,
                                loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                color: AppColors.gray,
                              );
                            },
                            errorBuilder:
                                (context, error, stackTrace) =>
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
                               color:  AppColors.blue,
                               border: Border.all(color: AppColors.white,width: 4)
                             ),
                             child: const Text('5',style: AppTextStyles.style12white600,),
                           ),
                         ),
                      ],
                    ),
                  ),
                  const Gap(3),
                  Text(
                    type ?? "",
                    style: AppTextStyles.style12darkGrey400,
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
                          backgroundColor: AppColors.gray,
                          verticalPadding: 4,
                          horizontalPadding: 6,
                        ),
                        const Gap(5),
                        IconTextContainerWidget(
                          image: AppImages.phone ,
                          text: phone ?? "",
                          backgroundColor: AppColors.gray,
                          verticalPadding: 4,
                          horizontalPadding: 6,
                        ),

                      ],
                    ),
                    const Gap(10),
                    IconTitleValueContainerWidget(
                      image: valueImage,
                      title: gate ?? "",
                      value: value ?? "",
                      backgroundColor: AppColors.gray,
                      verticalPadding: 4,
                      horizontalPadding: 6,
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
    );
  }
}
