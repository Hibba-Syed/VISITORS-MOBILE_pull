import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';

class TitleValueRowDividerDetailsContainerWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Color? textColor;
  final Color? valueColor;
  final IconData? valueIcon;
  final bool isLast;
  const TitleValueRowDividerDetailsContainerWidget({
    super.key,
    required this.title,
    this.value,
    this.textColor,
    this.valueColor,
    this.isLast = false,
    this.valueIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                title,
                style:  AppUtils.isTablet(context) ? AppTextStyles.style15Black600 :AppTextStyles.style13Black600,
              ),
            ),
            Expanded(
              flex: 5,
              child: valueIcon != null
                  ? Icon(
                valueIcon,
                color: valueColor ?? AppColors.red,
                size: AppUtils.isTablet(context) ? 20 : 16,
              )
                  : Text(
                value ?? "",
                style: (AppUtils.isTablet(context)
                    ? AppTextStyles.style15DarkGrey600
                    : AppTextStyles.style13DarkGrey600)
                    .copyWith(color: valueColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (!isLast)
          const Divider(
            color: AppColors.gray,
          ),
        // if (!isLast) const Gap(5),
      ],
    );
  }
}
