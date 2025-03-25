import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import 'components/directory_card_widget.dart';
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            SingleSelectedDropdownWidget<String?>(
                hint: "Select ",
                fillColor: AppColors.white,
                selectedItem: 'Select',
                itemAsString: (type) => type ?? "--",
                compareFn: (p0, p1) => p0 == p1,
                items: ['1','2','3','4'],
                onChanged: (value) {
                }),
            const Gap(20),
            const Text('RESIDENT INFORMATION',style: AppTextStyles.style14primary600,),
            const Gap(10),
            const DirectoryCardWidget(
              name: 'Fiza Rameez',
              phone: '23456789789',
              email: 'Fiza@gmail.com',
            ),
            const Gap(20),
            const Text('OWNER INFORMATION',style: AppTextStyles.style14primary600,),
            const Gap(10),
            const DirectoryCardWidget(
              name: 'Hamid Aijaz',
              phone: '23456789789',
              email: 'Hamid@gmail.com',
            ),
          ],
        ),
      ),
    );
  }
}
