import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';
import '../../../widgets/status_widget.dart';

class ServicesListCardWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? secondTitle;
  final String? count;
  final Widget? widget;
  final String? status;
  const ServicesListCardWidget({
    super.key,
    this.image,
    this.title,
    this.count,
    this.secondTitle,
    this.widget,
    this.status,
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
              color: AppColors.lightGrey1,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              count ?? "",
              style: AppTextStyles.style12Black500,
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
                      style: AppTextStyles.style12Black500,
                    ),
                    StatusWidget(
                      status: status ?? "N/A",
                      dotColor: AppColors.green,
                      statusColor: AppColors.green,
                      containerColor: AppColors.green.withAlpha(20),
                    ),
                  ],
                ),
                const Gap(1),
                Text(
                  secondTitle ?? "",
                  style: AppTextStyles.style10Grey400,
                ),
                const Gap(2),
                widget ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
