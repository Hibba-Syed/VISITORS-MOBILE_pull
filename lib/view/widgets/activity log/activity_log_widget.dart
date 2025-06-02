import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';
import 'package:visitors/utils/app_utils.dart';


class ActivityLogWidget extends StatelessWidget {
  final String? status;
  final String? byValue;
  final String? description;
  final String? dateTime;
  final bool? isLast;
  final double? verticalPadding;
  final double? horizontalPadding;
  const ActivityLogWidget(
      {super.key,
      this.status,
      this.byValue,
      this.description,
      this.dateTime,
      this.isLast,
      this.verticalPadding,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10, vertical: verticalPadding ?? 0),
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.values.first,
            isLast: isLast ?? false,
            afterLineStyle: const LineStyle(
              color: AppColors.lightGrey,
              thickness: 2,
            ),
            indicatorStyle: IndicatorStyle(
              indicatorXY: 0.0,
              width: 23,
              height: 23,
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              drawGap: true,
              indicator: Container(
                height: AppUtils.isTablet(context) ? 30 : 25,
                width: AppUtils.isTablet(context) ? 30 : 25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.log,
                    height: AppUtils.isTablet(context) ? 30 : 25,
                    width: AppUtils.isTablet(context) ? 30 : 25,
                    fit: BoxFit.fill,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            endChild: Container(
              constraints: const BoxConstraints(
                minHeight: 105,
                maxWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(status ?? "",
                            style: AppUtils.isTablet(context)
                                ? AppTextStyles.style16black600
                                : AppTextStyles.style14Black600),
                        Flexible(
                          child: Text(byValue ?? ""  ,
                              style: AppUtils.isTablet(context)
                                  ? AppTextStyles.style16Primary600
                                  : AppTextStyles.style14Primary600),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Text(
                      description ?? "",
                      style: AppUtils.isTablet(context)
                          ? AppTextStyles.style14DarkGrey600
                          : AppTextStyles.style13DarkGrey500,
                    ),
                    const Gap(10),
                    IconTextContainerWidget(
                      image: AppImages.date,
                      text: dateTime ?? "",
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
