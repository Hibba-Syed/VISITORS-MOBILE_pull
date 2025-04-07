import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_card_widget.dart' show ServicesCardWidget;
import 'package:visitors/view/Common%20Screens/services/components/services_filter_bottom_sheet.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/components/visitor_passes_card_widget.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/components/visitor_passes_filter_bottom_sheet.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/text field/search_text_field.dart';
class VisitorPassesScreen extends StatelessWidget {
  const VisitorPassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const AppBarWidget(
        title: 'Visitor Passes',
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
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
                      _visitorPassesFilterBottomSheet(context);
                    },
                  )
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child:  ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return  VisitorPassesCardWidget(
                    unit: "1004",
                    name: 'MUHAMMAD AHMED MOHAMMED ',
                    fromDate: 'Apr 03, 2025 - Aug 10, 2025 ',
                    phone: '34567895678',
                    email: 'email@gmail.com',
                    profileImageUrl: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    reference: 'VP001-25-00003',
                    company:"Ellington Residential Developments",
                    checkInOnPressed: (){},
                    serviceableOnPressed: (){
                      Navigator.pushNamed(context, AppRoutes.serviceableCheckInsScreen);
                    },

                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  _visitorPassesFilterBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const VisitorPassesFilterBottomSheet();
      },
    );
  }

}
