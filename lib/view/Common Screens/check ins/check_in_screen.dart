import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_container_widget.dart';
import 'package:visitors/view/widgets/Filter/filter_widget.dart';
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
            const Gap(10),
           Expanded(
             child: ListView.builder(
               shrinkWrap: true,
               primary: false,
               itemCount: 12,
                 itemBuilder: (context,index){
               return  CheckInCardWidget(
                 name: 'MUHAMMAD AHMED MOHAMMED ',
                 profileImage: "",
                 type: 'Guest',
                 date: DateFormat("MMM dd, yyyy ")
                     .format(DateTime.now()),
                 phone: '34567890098',
                 gate: "Gate",
                 value: "The W Residences Reception",
                 valueImage: AppImages.gate,
               );
             } ),
           ),
          ],
        ),
      ),
    );
  }
}