import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/all_check_out_design_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/utils/app_utils.dart';

class JobCheckInsScreen extends StatelessWidget {
  const JobCheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Job Check-Ins',
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding
        ),
        child: Column(
          children: [
            const Gap(20),
            Align(
              alignment: Alignment.bottomRight,
              child:
              CustomButton(
                  buttonColor: AppColors.red,
                  text: 'Check-Out All',
                  height:  AppUtils.isTablet(context)  ? 50 : 42,
                  width: AppUtils.isTablet(context) ? 200 : 150,
                  imageHeight: AppUtils.isTablet( context) ? 25 : 18,
                  borderRadius: 6,
                  image: AppImages.logoutCard,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CustomAlertDialogBox(
                          insetPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                          isCancelButtonDisable: true,
                          confirmButtonColor: AppColors.red,
                          confirmButtonText: 'Checkout All',
                          title: 'Checkout for All Check-Ins',
                          contentBuilder: (context, setState) {
                            return const Align(
                              alignment: Alignment.center,
                              child: AllCheckOutDesignWidget(),
                            );
                          },
                        );
                      },
                    );
                  }),
            ),
            const Gap(15),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return CheckInCardWidget(
                    isServiceable: true,
                    count: '3',
                    reference: "VP001-25-00003",
                    typeText: "10007",
                    name: 'MUHAMMAD AHMED MOHAMMED ',
                    profileImageUrl:
                    "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    type: 'Visitor Pass',
                    date: DateTimeUtil.getFormattedDateTime(
                        '2025-04-04T05:33:36.000000Z'),
                    phone: '34567890098',
                    gateValue: "The W Residences Reception",
                    purpose: 'Apartment Viewing / RE Agent',
                    checkOutOnPressed: () {
                      _showCheckoutDialog(context);
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

  void _showCheckoutDialog(BuildContext context) {
    final TextEditingController visitorsNoController = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title: 'Checkout for Ahmed',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              checkOutAllOnPress: () {},
              checkOutOnPress: () {},
              controller: visitorsNoController,
              logIsLast: true,
              visitorsCount: 2,
              horizontalPadding: 0,
              logDate: '2025-04-04T05:33:36.000000Z',
              logStatus: 'Check-In',
              logByValue: '',
              logDescription: '6 visitor(s) checked-in from gate ‘The W Residences',
            );
          },
        );
      },
    );
  }
}
