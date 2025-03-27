import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_card_widget.dart' show ServicesCardWidget;

import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/text field/search_text_field.dart';
class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child:  ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.servicesDetailsScreen);
                    },
                    child: ServicesCardWidget(
                      unit: '1006',
                      title: 'Facility Booking',
                      reference: 'FO202401101791',
                      status: 'Notified',
                      serviceType: 'Fit Out NOC',
                      name: 'Suhaan',
                      countValue: '10',
                      logoutOnPressed: (){},
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
