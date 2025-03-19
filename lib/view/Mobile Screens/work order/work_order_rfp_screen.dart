import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';

import '../../../resource/constants/images.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/app_bar/appbar_widget.dart';
import '../../widgets/search_text_field.dart';
import 'components/work_order_list_screen_card_widget.dart';
class WorkOrderRfpScreen extends StatefulWidget {
  const WorkOrderRfpScreen({super.key});

  @override
  State<WorkOrderRfpScreen> createState() => _WorkOrderRfpScreenState();
}

class _WorkOrderRfpScreenState extends State<WorkOrderRfpScreen> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidget(
        title: "work order",
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
                    },
                  )
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 10,
                itemBuilder: ( context,  index) {
                  return const WorkOrderListScreenCardWidget(
                    reference: 'HB202408072524',
                    status: 'Active',
                    name: 'Work Order',
                    title: '(2 Months) Services Contract',
                    secondTitle: 'Work Order',
                    containerText1: 'Onlinist Vendor',
                    containerImage1: AppImages.vendor,
                    containerImage2: AppImages.count,
                    containerText2: 'Check-In Count: 10',
                    image:  AppImages.hammer,
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                return const Padding(padding: EdgeInsets.symmetric(vertical: 5,));
              },
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}
