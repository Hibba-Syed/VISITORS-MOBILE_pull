import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';

import '../../../resource/constants/app_colors.dart' show AppColors;
class AllCheckOutDesignWidget extends StatelessWidget {
  const AllCheckOutDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppImages.logout,
          height: 30,
          width: 30,
          colorFilter: const ColorFilter.mode(
            AppColors.red,
            BlendMode.srcIn,
          ),
        ),
        const Gap(15),
        const  Text(
          'Are you sure you want to checkout currently listed checkins?',style: AppTextStyles.style12black500,
        ),
        const Gap(5),
        const  Text(
          'Selected filters will be applied',style: AppTextStyles.style12Black600,
        ),
        const Gap(15),
      ],
    );
  }
}
