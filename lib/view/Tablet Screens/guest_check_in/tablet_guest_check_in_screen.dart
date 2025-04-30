import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/Mobile%20Screens/guest%20check%20in/components/get_info_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart' show CustomButton;
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/container_widgets/type_container_widget.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';
import 'package:visitors/view/widgets/picker/custom_date_time_picker.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';



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
              const Gap(20),
              Align(
                alignment: Alignment.center,
                child: const NetworkImageWidget(url: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  height: 150,
                  width: 150,
                ),
              ),
              const Gap(25),
              Align(
                  alignment: Alignment.center,
                child: CustomButton(
                    buttonColor: AppColors.primary,
                    text: 'Scan ID',
                    fontSize: 20,
                     height: 60,
                    imageHeight: 25,
                    borderRadius: 6,
                    image: AppImages.scan,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              insetPadding: AppUtils.isTablet(context) ? EdgeInsets.all(90) : EdgeInsets.all(10),
                              hideBothButtons: true,
                              title: 'Select Type',
                              contentBuilder: (context, setState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Select any ID type for Scan',style:  AppUtils.isTablet(context) ?  AppTextStyles.style16black600 : AppTextStyles.style14Black600),
                                    Gap(20),
                                    AppUtils.isTablet(context) ?
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 85,vertical: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TypeContainerWidget(
                                            text: 'Passport',
                                            textSize: 16,
                                            iconSize: 30,
                                            padding: 10,
                                            heightContainer: 110,
                                            widthContainer: 110,
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TypeContainerWidget(
                                            text: 'Emirates Id',
                                            textSize: 16,
                                            iconSize: 30,
                                            padding: 10,
                                            heightContainer: 110,
                                            widthContainer: 110,
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TypeContainerWidget(
                                            text: 'Driving license',
                                            textSize: 16,
                                            iconSize: 30,
                                            padding: 10,
                                            heightContainer: 110,
                                            widthContainer: 110,
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ) :
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    )

                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
              const Gap(25),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
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
                        ),
                        const Gap(8),
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

                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),
                        ),
                        const Gap(10),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
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
                            outLineColor: AppColors.gray,
                            enabledBorder: InputBorder.none,
                            controller: _passportNumberController,
                            label: 'Passport Number',
                            hint: 'Passport Number',
                            keyboardType: TextInputType.text,

                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextFieldWidget(
                            outLineColor: AppColors.gray,
                            enabledBorder: InputBorder.none,
                            controller: _passportExpiryController,
                            label: 'Passport Expiry',
                            hint: 'Passport Expiry',
                            keyboardType: TextInputType.text,
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
                                },
                                validator:  (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'required';
                                  }
                                  return null;
                                },
                              ),
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
                                },
                                validator:  (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'required';
                                  }
                                  return null;
                                },
                              ),
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
                                },
                                validator:  (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'required';
                                  }
                                  return null;
                                },
                              ),
                            ],
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
                                "Nationality",
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
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: TextFieldWidget(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Enter Email',
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    TextFieldWidget(
                      controller: _cardNumberController,
                      label: 'Entry Card Number',
                      hint: 'Enter card number',
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
                            WidgetStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialogBox(
                                      hideBothButtons: true,
                                      insetPadding: AppUtils.isTablet( context) ?
                                      EdgeInsets.symmetric(horizontal: 35) : EdgeInsets.symmetric(horizontal: 10),
                                      title: 'Select Visitor',
                                      contentBuilder: (context, setState) {
                                        return const SelectVisitorNumberWidget(count: 3,);
                                      }
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
                      label: 'Description',
                      hint: 'Enter description',
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: CustomButton(
              height: AppUtils.isTablet(context) ? 55 : 42,
            fontSize: AppUtils.isTablet(context) ? 20: 15,
            imageHeight: AppUtils.isTablet(context) ? 25 : 18,
            image: AppImages.checkInButton,
              buttonColor: AppColors.green,
              text: 'Check-In', onPressed: (){
            if (_formKey.currentState!.validate()) {
             // print("Form is valid. Proceeding with check-in...");
            } else {
             // print("Form validation failed.");
            }
          }),
        ),
      ),
    );
  }
}

class SelectVisitorNumberWidget extends StatelessWidget {
  final int count;
  const SelectVisitorNumberWidget({
    super.key,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Text(
           count.toString(),
          style: AppTextStyles.style36Blue500,
        ),
         Text(
          'Visitor records found for this number',
          style:  AppUtils.isMobile(context) ? AppTextStyles.style14Black600 :AppTextStyles.style15Black600,
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
