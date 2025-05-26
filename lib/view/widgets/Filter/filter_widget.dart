import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visitors/resource/constants/images.dart';

import '../../../resource/constants/app_colors.dart';

class FilterContainerWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isFilterApplied;
  const FilterContainerWidget({
    super.key,
    required this.onPressed,
    this.isFilterApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onPressed,
      child: Container(
          height: 45,
          width: 45,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                AppImages.filter,
                width: 27,
                height: 27,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
             if(isFilterApplied)
             const Icon(
                Icons.circle,
                color: AppColors.green,
                size: 10,
              ),
            ],
          )),
    );
  }
}
