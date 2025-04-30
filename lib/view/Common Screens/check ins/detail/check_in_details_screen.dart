import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/stack_count_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/read_more_widget.dart';
import 'package:visitors/utils/app_utils.dart';

class CheckInDetailsScreen extends StatelessWidget {
  const CheckInDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(
        title: 'Check-In Details',
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              const Align(
                alignment: Alignment.center,
                child: StackCountContainerWidget(
                  count: 5,
                  imageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                ),
              ),
              const Gap(5),
              const HeadingWidget(heading: 'Guest Details',),
              const Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Column(
                  children: [
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Name',
                      value: 'Ahmed',
                    ),
                    const  TitleValueRowDividerDetailsContainerWidget(
                      title: 'Phone',
                      value: '971435446476',
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Email',
                      value: 'Ahmed@gmail.com',
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Unit',
                      value: '4',
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Current Visitors Count',
                      value: '4',
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Visit Purpose',
                      value: 'Apartment Viewing/RE Agent',
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Entry Card Number',
                      value: '456789',
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Nationality',
                      value: 'United Arab Emirates',
                    ),
                     TitleValueRowDividerDetailsContainerWidget(
                      title: 'Check-In Time',
                      value:  DateTimeUtil.getFormattedDateTime('2025-04-04T05:33:36.000000Z'),
                    ),
                    const TitleValueRowDividerDetailsContainerWidget(
                      title: 'Check-In Gate',
                      value: 'gate 2',
                    ),
                    const ReadMoreWidget(title: 'Description', valueText: 'They abbreviated "dolorem" (meaning "pain") to "lorem," which carries no meaning in Latin. "Ipsum" translates to "itself," and the text frequently includes phrases such as "consectetur adipiscing elit" and "ut labore et dolore." These Latin fragments, derived from Cicero philosophical treatise, were rearranged to create the standard dummy text that has become a fundamental tool in design and typography across generations.'),
                  ],
                ),
              ),
              const Gap(20),
              const Text('Check-In Log',style: AppTextStyles.style20primary600,),
              const Gap(10),
              ActivityLogWidget(
                isLast: true,
                status: 'Check-In',
                byValue: '',
                description: '6 visitor(s) checked-in from gate ‘The W Residences’',
                dateTime:  DateTimeUtil.getFormattedDateTime('2025-04-04T05:33:36.000000Z'),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.horizontalPadding),
        child:  CustomButton(
           fontSize:  AppUtils.isTablet(context) ? 20 : 15,
          height: AppUtils.isTablet(context)  ? 55 : 42,
          imageHeight: AppUtils.isTablet(context) ?25 :18,
          image:  AppImages.logoutCard,
            buttonColor:  AppColors.red,
            text: 'Check Out', onPressed: (){
          _showCheckoutDialog(context);
        }),
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
              visitorsCount: 11,
              horizontalPadding: 0,
              checkOutAllOnPress: () {  },
              checkOutOnPress: () {  },
              logIsLast: true,
              logDate: "2025-04-04T05:33:36.000000Z",
              controller: visitorsNoController,
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
