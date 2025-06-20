import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';

class ScanTypeContainerWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? textSize;
  final double? iconSize;
  final double? padding;
  final double? heightContainer;
  final double? widthContainer;

  const ScanTypeContainerWidget(
      {super.key,
      required this.text,
      required this.onTap,
      this.textSize,
      this.iconSize,
      this.padding,
      this.heightContainer,
      this.widthContainer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: DottedBorder(
        options: CircularDottedBorderOptions(
            strokeWidth: 1,
            dashPattern: [3, 3, 3, 3],
            color: AppColors.primary,
            padding: EdgeInsets.all(padding ?? 6),
            strokeCap: StrokeCap.round),
        child: Container(
          height: heightContainer ?? 90,
          width: widthContainer ?? 90,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.perm_contact_cal_outlined,
                color: AppColors.primary,
                size: iconSize ?? 23,
              ),
              Gap(5),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: textSize ?? 14,
                    color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
