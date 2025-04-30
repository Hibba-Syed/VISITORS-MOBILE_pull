import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/Mobile%20Screens/guest%20check%20in/components/get_info_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart' show CustomButton;
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';
import 'package:visitors/view/widgets/picker/custom_date_time_picker.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

import '../../widgets/container_widgets/type_container_widget.dart';


class MobileGuestCheckInScreen extends StatefulWidget {
  const MobileGuestCheckInScreen({super.key});

  @override
  State<MobileGuestCheckInScreen> createState() => _MobileGuestCheckInScreenState();
}

class _MobileGuestCheckInScreenState extends State<MobileGuestCheckInScreen> {

  final TextEditingController _visitorCountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passportExpiryController = TextEditingController();
  final TextEditingController _passportNumberController = TextEditingController();
  String? _selectedItemType;
  String? _selectedItemPurpose;
  String? _selectedItemUnit;
  String? _selectedItemNationality;
  String? _selectedIssueDate;
  String? _selectedExpiryDate;
  final List<String> _nationalityItems = [
    'pakistan',
    'Australia',
    'United Arab Emirates',
    'India'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Align(
              alignment: Alignment.center,
              child: NetworkImageWidget(url: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                height: 90,
                width: 90,
              ),
            ),
            const Gap(20),
            CustomButton(
                buttonColor: AppColors.primary,
                text: 'Scan ID',
                height: 41,
                borderRadius: 6,
                image: AppImages.scan,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialogBox(
                          insetPadding: EdgeInsets.all(10),
                          hideBothButtons: true,
                          title: 'Select Type',
                          contentBuilder: (context, setState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Select any ID type for Scan',style: AppTextStyles.style14Black600,),
                                Gap(15),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    TypeContainerWidget(
                                      text: 'Passport',
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TypeContainerWidget(
                                      text: 'Emirates Id',
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TypeContainerWidget(
                                      text: 'Driving license',
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      });
                  // _pickImage();
                }),

            const Gap(20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
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
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
                    enabledBorder: InputBorder.none,
                    controller: _idNumberController,
                    label: 'ID Number',
                    hint: 'Enter ID Number',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  const Text(
                    "Date of Issue",
                    style: AppTextStyles.style12Black600,
                  ),
                  const Gap(8),
                  CustomDateTimePickerWidget(
                    fillColor: AppColors.white,
                    hintText: 'Date of Issue',
                    onlyDatePicker: true,
                    selectedDateTime: _selectedIssueDate,
                    onChangeDateTime: (value) {
                      _selectedIssueDate = value;
                      //print('Selected Date: $value');
                    },
                  ),
                  const Gap(5),
                  const Text(
                    "Date of Expiry",
                    style: AppTextStyles.style12Black600,
                  ),
                  const Gap(8),
                  CustomDateTimePickerWidget(
                    fillColor: AppColors.white,
                    hintText: 'Date of Issue',
                    onlyDatePicker: true,
                    selectedDateTime: _selectedExpiryDate,
                    onChangeDateTime: (value) {
                      _selectedExpiryDate = value;
                      //print('Selected Date: $value');
                    },
                  ),
                  const Gap(5),
                  const Text(
                    "Nationality",
                    style: AppTextStyles.style12Black600,
                  ),
                  const Gap(8),
                  SingleSelectedDropdownWidget<String>(
                    outLineColor: AppColors.gray,
                    hint: "Select Nationality",
                    fillColor: AppColors.white,
                    selectedItem: _selectedItemNationality,
                    compareFn: (p0, p1) => p0 == p1,
                    items: _nationalityItems,
                    onChanged: (value) {
                      _selectedItemNationality = value;
                    },
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
                    enabledBorder: InputBorder.none,
                    controller: _passportNumberController,
                    label: 'Passport Number',
                    hint: 'Passport Number',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
                    enabledBorder: InputBorder.none,
                    controller: _passportExpiryController,
                    label: 'Passport Expiry',
                    hint: 'Passport Expiry',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                  const Gap(8),
                  const Text(
                    "Type*",
                    style: AppTextStyles.style12Black600,
                  ),
                  const Gap(8),
                  SingleSelectedDropdownWidget<String>(
                    outLineColor: AppColors.gray,
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
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
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
                  const Gap(5),
                  const Text(
                    "Purpose*",
                    style: AppTextStyles.style12Black600,
                  ),
                  const Gap(8),
                  SingleSelectedDropdownWidget<String>(
                    outLineColor: AppColors.gray,
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
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  const Text(
                    "Unit Number*",
                    style: AppTextStyles.style12Black600,
                  ),
                  const Gap(8),
                  SingleSelectedDropdownWidget<String>(
                    outLineColor: AppColors.gray,
                    hint: "Select Unit",
                    fillColor: AppColors.white,
                    selectedItem: _selectedItemUnit,
                    // itemAsString: (type) => type ?? "--",
                    compareFn: (p0, p1) => p0 == p1,
                    items: const ['233', '2', '4567'],
                    onChanged: (value) {
                      _selectedItemUnit = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
                    label: "Phone Number*",
                    hint: "+971",
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
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  title: 'Select Visitor',
                                  contentBuilder: (context, setState) {
                                    return const SelectVisitorNumberWidget(
                                      count: 3,
                                    );
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
                    outLineColor: AppColors.gray,
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter Email',
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
                    controller: _cardNumberController,
                    label: 'Entry Card Number',
                    hint: 'Enter card number',
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    outLineColor: AppColors.gray,
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Enter description',
                  ),
                ],
              ),
            ),

            //  Form(
           //   key: _formKey,
           //   child: Column(
           //     crossAxisAlignment: CrossAxisAlignment.start,
           //     children: [
           //       const Gap(20),
           //       const Text(
           //         "Type*",
           //         style: AppTextStyles.style12Black600,
           //       ),
           //       const Gap(8),
           //       SingleSelectedDropdownWidget<String>(
           //           outLineColor:  AppColors.gray,
           //           hint: "Select Type",
           //           fillColor: AppColors.white,
           //           selectedItem: _selectedItemType,
           //           compareFn: (p0, p1) => p0 == p1,
           //           items: const [
           //             'Unit Visit',
           //             'Community Visit',
           //           ],
           //           onChanged: (value) {
           //             _selectedItemType = value;
           //           },
           //         validator:  (value) {
           //           if (value == null || value.isEmpty) {
           //             return 'required';
           //           }
           //           return null;
           //         },
           //       ),
           //       const Gap(5),
           //       TextFieldWidget(
           //         outLineColor: AppColors.gray,
           //         controller: _visitorCountController,
           //         label: 'Visitor Count*',
           //         hint: 'Enter count',
           //         keyboardType: TextInputType.number,
           //         validator: (value) {
           //           if (value == null || value.isEmpty) {
           //             return 'required';
           //           }
           //           return null;
           //         },
           //       ),
           //       const Gap(5),
           //       const  Text(
           //         "Purpose*",
           //         style: AppTextStyles.style12Black600,
           //       ),
           //       const Gap(8),
           //       SingleSelectedDropdownWidget<String>(
           //           outLineColor:  AppColors.gray,
           //           hint: "Select Purpose",
           //           fillColor: AppColors.white,
           //           selectedItem: _selectedItemPurpose,
           //           compareFn: (p0, p1) => p0 == p1,
           //           items: const [
           //             'purpose',
           //             'purpose',
           //           ],
           //           onChanged: (value) {
           //             _selectedItemPurpose = value;
           //           },
           //         validator:  (value) {
           //           if (value == null || value.isEmpty) {
           //             return 'required';
           //           }
           //           return null;
           //         },
           //       ),
           //       const Gap(5),
           //       const Text(
           //         "Unit Number*",
           //         style: AppTextStyles.style12Black600,
           //       ),
           //       const Gap(8),
           //       SingleSelectedDropdownWidget<String>(
           //           outLineColor:  AppColors.gray,
           //           hint: "Select Unit",
           //           fillColor: AppColors.white,
           //           selectedItem: _selectedItemUnit,
           //           // itemAsString: (type) => type ?? "--",
           //           compareFn: (p0, p1) => p0 == p1,
           //           items: const ['233', '2', '4567'],
           //           onChanged: (value) {
           //             _selectedItemUnit = value;
           //           },
           //         validator:  (value) {
           //           if (value == null || value.isEmpty) {
           //             return 'required';
           //           }
           //           return null;
           //         },
           //       ),
           //       const Gap(5),
           //       TextFieldWidget(
           //         outLineColor: AppColors.gray,
           //         enabledBorder: InputBorder.none,
           //         controller: _nameController,
           //         label: 'Name*',
           //         hint: 'Enter Name',
           //         keyboardType: TextInputType.text,
           //         validator: (value) {
           //           if (value == null || value.isEmpty) {
           //             return 'required';
           //           }
           //           return null;
           //         },
           //       ),
           //       const Gap(5),
           //       TextFieldWidget(
           //         outLineColor: AppColors.gray,
           //         label:  "Phone Number*",
           //         hint:  "+971",
           //         controller: _phoneNumberController,
           //         validator: (value) {
           //           if (value == null || value.isEmpty) {
           //             return 'Required max length 13 digits';
           //           }
           //           if (!RegExp(r'^\d{7,13}$').hasMatch(value)) {
           //             return 'Please enter a valid mobile number';
           //           }
           //           return null;
           //         },
           //         keyboardType: TextInputType.number,
           //         inputFormatters: [
           //           LengthLimitingTextInputFormatter(13),
           //         ],
           //         suffix: Container(
           //           decoration: BoxDecoration(
           //               borderRadius: const BorderRadius.only(
           //                 topRight: Radius.circular(5),
           //                 bottomRight: Radius.circular(5),
           //               ),
           //               border: Border.all(color: AppColors.primary)),
           //           child: TextButton(
           //             style: ButtonStyle(
           //               overlayColor:
           //               MaterialStateProperty.all(Colors.transparent),
           //             ),
           //             onPressed: () {
           //               showDialog(
           //                   barrierDismissible: false,
           //                   context: context,
           //                   builder: (context) {
           //                     return CustomAlertDialogBox(
           //                       hideBothButtons: true,
           //                       insetPadding:
           //                       const EdgeInsets.symmetric(horizontal: 10),
           //                       title: 'Select Visitor',
           //                       contentBuilder: (context, setState) {
           //                         return const SelectVisitorNumberWidget();
           //                       },
           //                     );
           //                   });
           //             },
           //             child: const Text("Get Info",
           //                 style: TextStyle(color: AppColors.primary)),
           //           ),
           //         ),
           //       ),
           //       const Gap(5),
           //       TextFieldWidget(
           //         outLineColor: AppColors.gray,
           //         controller: _emailController,
           //         label: 'Email',
           //         hint: 'Enter Email',
           //         // validator: (value) {
           //         //   if (value == null || value.isEmpty) {
           //         //     return 'required';
           //         //   }
           //         //   return null;
           //         // },
           //       ),
           //       const Gap(5),
           //       const  Text(
           //         "Nationality",
           //         style: AppTextStyles.style12Black600,
           //       ),
           //       const Gap(8),
           //       SingleSelectedDropdownWidget<String>(
           //           outLineColor:  AppColors.gray,
           //           hint: "Select Nationality",
           //           fillColor: AppColors.white,
           //           selectedItem: _selectedItemNationality,
           //           compareFn: (p0, p1) => p0 == p1,
           //           items: const [
           //             'pakistan',
           //             'Australia',
           //           ],
           //           onChanged: (value) {
           //             _selectedItemNationality = value;
           //           },
           //           ),
           //       const Gap(5),
           //       TextFieldWidget(
           //         outLineColor: AppColors.gray,
           //         controller: _cardNumberController,
           //         label: 'Entry Card Number',
           //         hint: 'Enter card number',
           //       ),
           //       const Gap(5),
           //       TextFieldWidget(
           //         outLineColor: AppColors.gray,
           //         controller: _descriptionController,
           //         label: 'Description',
           //         hint: 'Enter description',
           //       ),
           //     ],
           //   ),
           // ),

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
            text: 'Check-In', onPressed: (){
    if (_formKey.currentState!.validate()) {
    print("Form is valid. Proceeding with check-in...");
    } else {
      print("Form validation failed.");
    }
        }),
      ),
    );
  }
}

class SelectVisitorNumberWidget extends StatelessWidget {
  final int? count;
  const SelectVisitorNumberWidget({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          count.toString(),
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
