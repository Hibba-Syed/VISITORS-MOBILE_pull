import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_filter_bottom_sheet.dart';
import 'package:visitors/view/widgets/Filter/filter_widget.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/button/action_button.dart'
    show ActionButton;
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/text%20field/search_text_field.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

class CheckInsScreen extends StatelessWidget {
  const CheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Flexible(child: SearchTextField()),
                  const Gap(6),
                  FilterContainerWidget(
                    onPressed: () {
                      _checkInFilterBottomSheet(context);
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
                buttonWidth: 145,
                onPressed: () {},
              ),
            ),
            const Gap(5),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.checkInDetailsScreen);
                    },
                    child: CheckInCardWidget(
                      count: 5,
                      typeImage: AppImages.community,
                      typeText: "Community Visit",
                      reference: 'FO202401101791',
                      name: 'MUHAMMAD AHMED MOHAMMED ',
                      profileImageUrl:
                          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                      type: 'Guest',
                      date: DateFormat("MMM dd, yyyy ").format(DateTime.now()),
                      phone: '34567890098',
                      gateValue: "The W Residences Reception",
                      checkOutOnPressed: () {
                        final  TextEditingController _visitorsNoController = TextEditingController();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return CustomAlertDialogBox(
                                    insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    hideBothButtons: true,
                                    title: 'Checkout for Ahmed',
                                    contentBuilder: (context, setState) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '3',
                                            style: AppTextStyles.style36Red500,
                                          ),
                                          const Gap(5),
                                          TextFieldWidget(
                                            controller: _visitorsNoController,
                                            hint: 'No. of visitors checking-out',
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                          ),
                                          const Gap(20),
                                          _visitorsNoController.text.isEmpty
                                              ? CustomButton(
                                            borderRadius: 6,
                                            buttonColor: AppColors.red,
                                            height: 42,
                                            text: 'Check-Out All',
                                            onPressed: () {},
                                          )
                                              : Row(
                                            children: [
                                              Expanded(
                                                child: CustomButton(
                                                  borderRadius: 6,
                                                  invert: true,
                                                  height: 42,
                                                  buttonColor: AppColors.red,
                                                  textColor: AppColors.red,
                                                  text: 'Check-Out',
                                                  onPressed: () {},
                                                ),
                                              ),
                                              const Gap(8),
                                              Expanded(
                                                child: CustomButton(
                                                  borderRadius: 6,
                                                  buttonColor: AppColors.red,
                                                  height: 42,
                                                  text: 'Check-Out All',
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Gap(10),
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Check-In Log',
                                              style: AppTextStyles.style14Black600,
                                            ),
                                          ),
                                          const Divider(color: AppColors.gray),
                                          const Gap(5),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(maxHeight: 250),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: 3,
                                              itemBuilder: (context, index) {
                                                return ActivityLogWidget(
                                                  status: 'Check-In',
                                                  byValue: '',
                                                  description:
                                                  '6 visitor(s) checked-in from gate ‘The W Residences’',
                                                  dateTime: DateFormat("MMM dd, yyyy, hh:mm a")
                                                      .format(DateTime.now()),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }
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

  _checkInFilterBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const CheckInFilterBottomSheet();
      },
    );
  }
}
