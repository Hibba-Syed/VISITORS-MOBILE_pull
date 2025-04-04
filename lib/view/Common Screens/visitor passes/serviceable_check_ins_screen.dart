import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_filter_bottom_sheet.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/components/serviceable_check_ins_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/action_button.dart' show ActionButton;
class ServiceableCheckInsScreen extends StatelessWidget {
  const ServiceableCheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(
        title: 'Serviceable Check-Ins',
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: Column(
          children: [
            const Gap(20),
            Align(
              alignment: Alignment.bottomRight,
              child: ActionButton(
                text: 'Check-Out All',
                image: AppImages.logout,
                imageColor: AppColors.white,
                backgroundColor: AppColors.red,
                onPressed: (){
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return ServiceableCheckInsCardWidget(
                    count: '11',
                    reference: "VP001-25-00003",
                    typeText: "10007",
                    name: 'MUHAMMAD AHMED MOHAMMED ',
                    profileImageUrl: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    type: 'Visitor Pass',
                    date: DateFormat("MMM dd, yyyy ")
                        .format(DateTime.now()),
                    phone: '34567890098',
                    gateValue: "The W Residences Reception",
                    purpose: 'Apartment Viewing / RE Agent',
                    checkOutOnPressed: (){},

                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(padding: EdgeInsets.symmetric(vertical: 5));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}