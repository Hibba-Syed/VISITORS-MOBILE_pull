import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_filter_bottom_sheet.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_rfp_card_widget.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/text field/search_text_field.dart';
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
                      _workOrderFilterBottomSheet(context);
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
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.workOrderJobDetailsScreen);
                    },
                    child: WorkOrderRFPCardWidget(
                        typeAssetImage: AppImages.hammer,
                        typeText: 'Work Order',
                        status: 'Active',
                        title: '(2 Months) Services Contract',
                        reference: 'JB001-24-00102',
                        vendorName: 'Mohammed Faisal Al-Haddad',
                        date: 'Jan 7, 2025',
                        checkInPressed: (){}
                    ),
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
  _workOrderFilterBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const WorkOrderFilterBottomSheet();
      },
    );
  }
}
