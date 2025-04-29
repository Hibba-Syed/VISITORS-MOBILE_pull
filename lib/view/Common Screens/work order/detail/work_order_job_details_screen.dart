import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/phone_email_information_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

class WorkOrderJobDetailsScreen extends StatelessWidget {
  const WorkOrderJobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Job Details',
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingWidget(heading: 'Work Order'),
                  StatusWidget(status: 'Active'),
                ],
              ),
              const Gap(3),
               HeadingWidget(
                heading: 'JB001-22-00092',
                style:  AppConstants.isTablet(context) ?  AppTextStyles.style15Black600 : AppTextStyles.style14Black600,
              ),
              const Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding,
            vertical: AppConstants.horizontalPadding),
        child: CustomButton(
            height:  AppConstants.isTablet(context) ? 55 : 42,
            text: 'Add Log',
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    TextEditingController _noteController =
                        TextEditingController();
                    return CustomAlertDialogBox(
                      isCancelButtonDisable: true,
                      insetPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      title: 'Add Log to JB001-24-00102',
                      confirmButtonText: 'Add Log',
                      onConfirm: () async {
                        return false;
                      },
                      contentBuilder: (context, setState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Gap(5),
                            SvgPicture.asset(
                              AppImages.question,
                              height: 35,
                              width: 35,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const Gap(5),
                            TextFieldWidget(
                              controller: _noteController,
                              label: 'Note *',
                            ),
                          ],
                        );
                      },
                    );
                  });
            }),
      ),
    );
  }
}
