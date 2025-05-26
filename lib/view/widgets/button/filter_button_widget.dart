import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';

class FilterButtonWidget extends StatelessWidget {
  final VoidCallback applyOnPressed;
  final VoidCallback clearOnPressed;
  const FilterButtonWidget({
    super.key,
    required this.applyOnPressed,
    required this.clearOnPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: clearOnPressed,
          child: Container(
              height: 45,
              width: 45,
              padding:  const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gray)),
              child: SvgPicture.asset(
                AppImages.noFilter,
                width: 7,
                height: 7,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: InkWell(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: applyOnPressed,
            child: CustomButton(
                height: 45, text: 'Apply Filters', onPressed: applyOnPressed,),
          ),
        ),
      ],
    );
  }
}
