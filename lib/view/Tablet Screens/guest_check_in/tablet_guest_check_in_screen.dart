import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Mobile%20Screens/guest%20check%20in/components/get_info_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart' show CustomButton;
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';


class TabletGuestCheckInScreen extends StatefulWidget {
  const TabletGuestCheckInScreen({super.key});

  @override
  State<TabletGuestCheckInScreen> createState() => _TabletGuestCheckInScreenState();
}

class _TabletGuestCheckInScreenState extends State<TabletGuestCheckInScreen> {
  final TextEditingController _visitorCountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  String? _selectedItemType;
  String? _selectedItemPurpose;
  String? _selectedItemUnit;
  String? _selectedItemNationality;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Guest Check-In',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                       const NetworkImageWidget(url: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        height: 100,
                        width: 100,
                      ),
                       const Gap(20),
                      CustomButton(
                          buttonColor: AppColors.primary,
                          text: 'Scan ID',
                          height: 41,
                          width: 210,
                          borderRadius: 6,
                          image: AppImages.scan,
                          onPressed: () {
                          }),
                    ],
                  ),
                  const Gap(10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'ID Number',
                            value: '5678967',
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Issue Date',
                            value: '--',
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Expiry Date',
                            value: '--',
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Passport Number',
                            value: '234567890',
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                            title: 'Passport Expiry',
                            value: 'Aug 7, 2025',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Type*",
                          style: AppTextStyles.style12Black600,
                        ),
                        const Gap(8),
                        SingleSelectedDropdownWidget<String>(
                            hint: "Select Type",
                            fillColor: AppColors.white,
                            selectedItem: _selectedItemType,
                            compareFn: (p0, p1) => p0 == p1,
                            items: const [
                              'Unit Visit',
                              'Community Visit',
                            ],
                            onChanged: (value) {
                              _selectedItemType = value;
                            }),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFieldWidget(
                      controller: _visitorCountController,
                      label: 'Visitor Count*',
                      hint: 'Enter count',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Gap(5),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const  Text(
                        "Purpose*",
                        style: AppTextStyles.style12Black600,
                      ),
                      const Gap(8),
                      SingleSelectedDropdownWidget<String>(
                          hint: "Select Purpose",
                          fillColor: AppColors.white,
                          selectedItem: _selectedItemPurpose,
                          compareFn: (p0, p1) => p0 == p1,
                          items: const [
                            'purpose',
                            'purpose',
                          ],
                          onChanged: (value) {
                            _selectedItemPurpose = value;
                          }),
                    ],
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Unit Number*",
                        style: AppTextStyles.style12Black600,
                      ),
                      const Gap(8),
                      SingleSelectedDropdownWidget<String>(
                          hint: "Select Unit",
                          fillColor: AppColors.white,
                          selectedItem: _selectedItemUnit,
                          // itemAsString: (type) => type ?? "--",
                          compareFn: (p0, p1) => p0 == p1,
                          items: const ['233', '2', '4567'],
                          onChanged: (value) {
                            _selectedItemUnit = value;
                          }),
                    ],
                  ),
                ),
              ],
            ),
              const Gap(5),
               Row(
                 children: [
                   Expanded(
                     child: TextFieldWidget(
                       enabledBorder: InputBorder.none,
                      controller: _nameController,
                       label: 'Name*',
                       hint: 'Enter Name',
                       keyboardType: TextInputType.text,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'required';
                         }
                         return null;
                       },
                     ),
                   ),
                   const Gap(10),
                   Expanded(
                     child: TextFieldWidget(
                       controller: _emailController,
                       label: 'Email*',
                       hint: 'Enter Email',

                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'required';
                         }
                         return null;
                       },
                     ),
                   ),
                 ],
               ),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  Text(
                          "Nationality*",
                          style: AppTextStyles.style12Black600,
                        ),
                        const Gap(8),
                        SingleSelectedDropdownWidget<String>(
                            hint: "Select Nationality",
                            fillColor: AppColors.white,
                            selectedItem: _selectedItemNationality,
                            compareFn: (p0, p1) => p0 == p1,
                            items: const [
                              'pakistan',
                              'Australia',
                            ],
                            onChanged: (value) {
                              _selectedItemNationality = value;
                            }),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFieldWidget(
                      controller: _cardNumberController,
                      label: 'Entry Card Number*',
                      hint: 'Enter card number',

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                    ),
                  ),

                ],
              ),
              const Gap(5),
              TextFieldWidget(
                label:  "Phone Number*",
                hint:  "Enter phone number",
                controller: _phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required max length 13 digits';
                  }
                  if (!RegExp(r'^\d{7,13}$').hasMatch(value)) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                ],
                suffix: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      border: Border.all(color: AppColors.primary)),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              hideBothButtons: true,
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              title: 'Select Visitor',
                              contentBuilder: (context, setState) {
                                return const SelectVisitorNumberWidget();
                              },
                            );
                          });
                    },
                    child: const Text("Get Info",
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ),
              ),
              const Gap(5),
              TextFieldWidget(
                controller: _descriptionController,
                label: 'Description*',
                hint: 'Enter description',

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required';
                  }
                  return null;
                },
              ),

            ],
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: CustomButton(
            image: AppImages.checkInButton,
              buttonColor: AppColors.green,
              text: 'Check-In', onPressed: (){}),
        ),
      ),
    );
  }
}

class SelectVisitorNumberWidget extends StatelessWidget {
  const SelectVisitorNumberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '3',
          style: AppTextStyles.style36Blue500,
        ),
        const Text(
          'Visitor records found for this number',
          style: AppTextStyles.style14Black600,
        ),
        const Divider(
          color: AppColors.lightGrey,
        ),
        const Gap(5),
        ConstrainedBox(
          constraints: const BoxConstraints(
               maxHeight: 250),
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: 2,
            itemBuilder: (context, index) {
              return const GetInfoCardWidget(
                name:
                    'Muhammad Ahmad Bin Ali Al Shehzad ur Rahman',
                country: 'pakistan',
                profileImageUrl:
                    'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: AppColors.lightGrey,
              );
            },
          ),
        ),
      ],
    );
  }
}
