import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
class ServiceDetails extends StatelessWidget {
  const ServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Service Details',
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
                const Row(
                  children: [
                     HeadingWidget(heading: 'Facility Booking | ',),
                     HeadingWidget(heading: 'HB202408072524',style: AppTextStyles.style16black600,),
                    Spacer(),
                    StatusWidget(
                        status: 'Approved'
                    ),
                  ],
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Facility',
                        value: 'Hall',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Nature of function',
                        value: 'Birthday Celebration',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Expected Guests',
                        value: '25',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Booking Date',
                        value: 'Aug 7, 2024',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Start Time',
                        value: '11:00 PM',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        isLast: true,
                        title: 'End Time',
                        value: '03:00 PM',
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                const HeadingWidget(heading: 'Applicant Details',),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Requester Type',
                        value: 'Owner',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Name',
                        value: 'Oliver Stone',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Phone',
                        value: '9714567890',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Email',
                        value: 'Oliver@gmail.com',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Passport Number',
                        value: '345678905678',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Passport Expiry',
                        value: 'Apr 15, 2025',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'ID Number',
                        value: '543745278980',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        isLast: true,
                        title: 'ID Expiry',
                        value: 'Oct 19, 2025',
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                const Text('Activity Log',style: AppTextStyles.style18primary600,),
                const Gap(10),
                ActivityLogWidget(
                  status: 'Request Received By ',
                  byValue: 'System',
                  description: 'Application has been submitted successfully',
                  dateTime: DateFormat("MMM dd, yyyy, hh:mm a").format(DateTime.now()),
                ),
            
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.horizontalPadding),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                    height: 40,
                    text: 'Add Log', onPressed: (){}),
              ),
              const Gap(10),
              Expanded(
                child: CustomButton(
                  buttonColor: AppColors.green,
                    height: 40,
                    text: 'Complete', onPressed: (){}),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
