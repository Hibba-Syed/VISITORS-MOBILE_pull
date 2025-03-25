import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/widgets/Filter/filter_widget.dart';
import 'package:visitors/view/widgets/button/action_button.dart' show ActionButton;
import 'package:visitors/view/widgets/search_text_field.dart';
class CheckInsScreen extends StatelessWidget {
  const CheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            const Gap(20),
            Align(
              alignment: Alignment.bottomRight,
              child: ActionButton(
                text: 'Check-Outs All',
                image: AppImages.checkout,
                imageColor: AppColors.white,
                backgroundColor: AppColors.red,
                verticalPadding: 7,
                buttonWidth: 140,
                onPressed: (){
                },
              ),
            ),
            const Gap(15),
           Expanded(
             child:  ListView.separated(
               padding: const EdgeInsets.only(bottom: 10,top: 35),
               shrinkWrap: true,
               primary: false,
               itemCount: 12,
               itemBuilder: (context, index) {
                 return CheckInCardWidget(
                   name: 'MUHAMMAD AHMED MOHAMMED ',
                   profileImageUrl: "",
                   type: 'Guest',
                   date: DateFormat("MMM dd, yyyy ")
                       .format(DateTime.now()),
                   phone: '34567890098',
                   gateValue: "The W Residences Reception",

                 );
               },
               separatorBuilder: (BuildContext context, int index) {
                 return const Padding(padding: EdgeInsets.symmetric(vertical: 20));
               },
             ),
           ),
          ],
        ),
      ),
    );
  }
}