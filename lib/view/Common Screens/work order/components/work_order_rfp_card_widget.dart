import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/overlap_container_widget.dart';

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
  final String? typeText;
  final String? typeAssetImage;

  final VoidCallback? checkInPressed;
  const WorkOrderRFPCardWidget({super.key,
    this.title,
    this.status,
    this.vendorName,
    this.date,
    this.reference,
    this.typeText,
    this.checkInPressed,
    this.typeAssetImage,
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
              text: typeText,
              image: typeAssetImage,
            ),
            OverlapContainerWidget(
              text: reference,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Container(
                    //   width: 65,
                    //   height: 65,
                    //   padding: const EdgeInsets.all(0),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.gray,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       const Gap(15),
                    //       SizedBox(
                    //         height: 20,
                    //         width: 20,
                    //         child: SvgPicture.asset(
                    //           AppImages.hammer,
                    //           width: 16,
                    //           height: 16,
                    //           colorFilter: const ColorFilter.mode(
                    //             AppColors.primary,
                    //             BlendMode.srcIn,
                    //           ),
                    //         ),
                    //       ),
                    //       const Gap(2),
                    //       const Expanded(child: Text("Work Order",style: AppTextStyles.style8Primary500,textAlign: TextAlign.center,
                    //         maxLines: 2,)),
                    //     ],
                    //   ),
                    // ),
                    // const Gap(5),
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
                        text: DateTimeUtil.getFormattedDateTime(date),
                      ),
                    ],
                  ),

                ],
              ),
              const Gap(10),
              LogoutButton(
                text: 'Check-In',
                onPressed: checkInPressed,
                backgroundColor:  AppColors.green ,
                image: AppImages.checkInButton,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
