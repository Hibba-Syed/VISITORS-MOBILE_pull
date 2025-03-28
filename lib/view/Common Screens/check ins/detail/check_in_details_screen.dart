import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/read_more_widget.dart';
class CheckInDetailsScreen extends StatelessWidget {
  const CheckInDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
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
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            color: AppColors.gray,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(0),
                const HeadingWidget(heading: 'Guest Details',),
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
                        title: 'Name',
                        value: 'Ahmed',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Phone',
                        value: '971435446476',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Email',
                        value: 'Ahmed@gmail.com',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Unit',
                        value: '4',
                      ),TitleValueRowDividerDetailsContainerWidget(
                        title: 'Current Visitor Count',
                        value: '4',
                      ),TitleValueRowDividerDetailsContainerWidget(
                        title: 'Visit Purpose',
                        value: 'Apartment Viewing/RE Agent',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Entry Card Number',
                        value: '456789',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Nationality',
                        value: 'United Arab Emirates',
                      ),
                      TitleValueRowDividerDetailsContainerWidget(
                        title: 'Check-In Time',
                        value: 'Jan 7, 2025, 10:40 AM',
                      ),TitleValueRowDividerDetailsContainerWidget(
                        title: 'Check-In Gate',
                        value: 'gate 2',
                      ),
                      ReadMoreWidget(title: 'Description', valueText: 'They abbreviated "dolorem" (meaning "pain") to "lorem," which carries no meaning in Latin. "Ipsum" translates to "itself," and the text frequently includes phrases such as "consectetur adipiscing elit" and "ut labore et dolore." These Latin fragments, derived from Cicero philosophical treatise, were rearranged to create the standard dummy text that has become a fundamental tool in design and typography across generations.'),
                    ],
                  ),
                ),
                const Gap(20),
                const Text('Check-In Log',style: AppTextStyles.style18primary600,),
                const Gap(10),
                ActivityLogWidget(
                  status: 'Check-In',
                  byValue: '',
                  description: '6 visitor(s) checked-in from gate ‘The W Residences’',
                  dateTime: DateFormat("MMM dd, yyyy, hh:mm a").format(DateTime.now()),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.horizontalPadding),
          child:  LogoutButton(
            text: 'Check Out',
            onPressed: (){},
            image: AppImages.logout,
            backgroundColor: AppColors.red,
          ),
        ),
      ),
    );
  }
}
