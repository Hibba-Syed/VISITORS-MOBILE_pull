import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/phone_email_information_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
class WorkOrderJobDetailsScreen extends StatelessWidget {
  const WorkOrderJobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Job Details',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
               const Row(
                children: [
                  HeadingWidget(heading: 'Work Order | '),
                  HeadingWidget(heading: 'JB001-22-00092',style: AppTextStyles.style16black600,),
                  Spacer(),
                  StatusWidget(
                      status: 'Active'
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
                      title: 'Title',
                       value: '(2 Months) Services Contract',
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: 'Category',
                       value: 'Services',
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: 'Assets',
                       value: 'Door',
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: 'Start Date',
                       value: 'Aug 7, 2024',
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      isLast: true,
                      title: 'End Date',
                       value: 'Aug 8, 2024',
                    ),
                  ],
                ),
              ),
              const Gap(20),
             const HeadingWidget(heading: 'Vendor Details'),
              const Gap(10),
              const PhoneEmailInformationCardWidget(
                name: 'Onlinist Vendorr',
                phone: '23456789789',
                email: 'support@onlinist.com',
              ),
              const Gap(20),
              const HeadingWidget(heading: 'Contact Person'),
              const Gap(10),
              const PhoneEmailInformationCardWidget(
                name: 'Hamid Aijaz',
                phone: '23456789789',
                email: 'Hamid@gmail.com',
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.horizontalPadding),
          child: CustomButton(
              height: 40,
              text: 'Add Log', onPressed: (){}),
        ),
      ),
    );
  }
}
