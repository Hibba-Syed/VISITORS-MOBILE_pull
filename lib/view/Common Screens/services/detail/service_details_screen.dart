import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Service Details',
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
                    HeadingWidget(
                      heading: 'Facility Booking',
                    ),
                    StatusWidget(status: 'Approved'),
                  ],
                ),
                const Gap(3),
                const HeadingWidget(
                  heading: 'HB2024080725',
                  style: AppTextStyles.style14Black600,
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
                const HeadingWidget(
                  heading: 'Applicant Details',
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
                const Text(
                  'Activity Log',
                  style: AppTextStyles.style20primary600,
                ),
                const Gap(10),
                ActivityLogWidget(
                  isLast: true,
                  status: 'Request Received By ',
                  byValue: 'System',
                  description: 'Application has been submitted successfully',
                  dateTime: DateFormat("MMM dd, yyyy, hh:mm a")
                      .format(DateTime.now()),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.horizontalPadding),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                    height: 40,
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
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Gap(5),
                                    SvgPicture.asset(
                                      AppImages.question,
                                      height: 35,
                                      width: 35,
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      controller: _noteController,
                                      label: 'Note*',
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
              const Gap(10),
              Expanded(
                child: CustomButton(
                    buttonColor: AppColors.green,
                    height: 40,
                    text: 'Complete',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            TextEditingController noteController =
                                TextEditingController();
                            TextEditingController nameController =
                                TextEditingController();
                            TextEditingController idController =
                                TextEditingController();
                            return CustomAlertDialogBox(
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              title: 'Complete HB2024080725',
                              disableCancelButtonBorder: true,
                              cancelButtonTextColor: AppColors.white,
                              cancelButtonColor: AppColors.green,
                              cancelButtonText: 'Complete',
                              confirmButtonText: 'Scan ID',
                              confirmButtonColor: AppColors.primary,
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
                                        AppColors.green,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      label: 'Requester Name',
                                      controller: nameController,
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      label: 'ID Number',
                                      controller: nameController,
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      controller: noteController,
                                      label: 'Note*',
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
