import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/styles/styles.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/search_text_field.dart';
class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Flexible(
                      child: SearchTextField()
                  ),
                  const Gap(6),
                  FilterContainerWidget(
                    onPressed: () {
                    },
                  )
                ],
              ),
            ),
            const Gap(10),
            // Expanded(
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     primary: false,
            //     itemCount: 10,
            //     itemBuilder: ( context,  index) {
            //       return const WorkOrderListScreenCardWidget(
            //         reference: 'HB202408072524',
            //         status: 'Active',
            //         name: 'Work Order',
            //         title: '(2 Months) Services Contract',
            //         secondTitle: 'Work Order',
            //         containerText1: 'Onlinist Vendor',
            //         containerImage1: AppImages.vendor,
            //         containerImage2: AppImages.count,
            //         containerText2: 'Check-In Count: 10',
            //         image:  AppImages.hammer,
            //       );
            //     }, separatorBuilder: (BuildContext context, int index) {
            //     return const Padding(padding: EdgeInsets.symmetric(vertical: 5,));
            //   },
            //
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
