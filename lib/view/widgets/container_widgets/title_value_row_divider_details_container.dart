import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';

class TitleValueRowDividerDetailsContainerWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Color? textColor;
  final Color? valueColor;
  final bool isLast;
  const TitleValueRowDividerDetailsContainerWidget({
    super.key,
    required this.title,
    this.value,
    this.textColor,
    this.valueColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: AppTextStyles.style12Black600,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value ?? "",
                style: AppTextStyles.style12DarkGrey500,
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
