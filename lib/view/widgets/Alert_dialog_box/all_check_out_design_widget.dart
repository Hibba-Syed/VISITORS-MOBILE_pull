import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';

import '../../../resource/constants/app_colors.dart' show AppColors;
import '../../../utils/app_utils.dart';
class AllCheckOutDesignWidget extends StatelessWidget {
  const AllCheckOutDesignWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppImages.logoutCard,
          height: 30,
          width: 30,
          colorFilter: const ColorFilter.mode(
            AppColors.red,
            BlendMode.srcIn,
          ),
        ),
        const Gap(15),
        Text(
          AppUtils.languageTranslate('areYouSureYouWantToCheckoutCurrentlyListedCheckins'),style: AppUtils.isTablet(context) ?  AppTextStyles.style16Black500 : AppTextStyles.style14Black500 ,
        ),
        const Gap(5),
          Text(
            AppUtils.languageTranslate('selectedFiltersWillBeApplied'),style: AppUtils.isTablet(context) ? AppTextStyles.style15Black600 : AppTextStyles.style14Black600,
        ),
        const Gap(15),
      ],
    );
  }
}
