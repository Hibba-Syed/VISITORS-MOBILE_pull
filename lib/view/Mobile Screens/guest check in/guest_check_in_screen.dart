import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:gap/gap.dart' show Gap;
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/action_button.dart';
import 'package:visitors/view/widgets/button/logout_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
class GuestCheckInScreen extends StatefulWidget {
  const GuestCheckInScreen({super.key});

  @override
  State<GuestCheckInScreen> createState() => _GuestCheckInScreenState();
}

class _GuestCheckInScreenState extends State<GuestCheckInScreen> {
  TextEditingController visitorCountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  String? selectedItemType;
  String? selectedItemPurpose;
  String? selectedItemUnit;
  String? selectedItemNationality;


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Guest Check-In',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.verticalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child:
                    ClipOval(
                      child: Image.network(
                         "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        loadingBuilder:
                            (context, child, loadingProgress) {
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
                const Gap(20),
                  const ActionButton(
                    verticalPadding: 10,
                  image: AppImages.scan,
                   text: "Scan ID",
                   textColor: AppColors.white,
                ),
                const Gap(20),
                Container(
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
                const Gap(20),
                const Align(
                  alignment: Alignment.topLeft,
                    child: Text("Type*",style: AppTextStyles.style12Black600,)),
                const Gap(8),
                SingleSelectedDropdownWidget<String>(
                    hint: "Select ",
                    fillColor: AppColors.white,
                    selectedItem: selectedItemType,
                    compareFn: (p0, p1) => p0 == p1,
                    items: const ['Unit Visit','Community Visit',],
                    onChanged: (value) {
                      selectedItemType= value;
                    }),
                fieldsTile(
                  "Visitor Count*",
                  "Enter count",
                  controller: visitorCountController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Purpose*",style: AppTextStyles.style12Black600,)),
                const Gap(8),
                SingleSelectedDropdownWidget<String>(
                    hint: "Select ",
                    fillColor: AppColors.white,
                    selectedItem: selectedItemPurpose,
                    compareFn: (p0, p1) => p0 == p1,
                    items: const ['purpose','purpose',],
                    onChanged: (value) {
                      selectedItemPurpose = value;
                    }),
                const Gap(10),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Unit Number*",style: AppTextStyles.style12Black600,)),
                const Gap(8),
                SingleSelectedDropdownWidget<String>(
                    hint: "Select ",
                    fillColor: AppColors.white,
                    selectedItem: selectedItemUnit,
                    // itemAsString: (type) => type ?? "--",
                    compareFn: (p0, p1) => p0 == p1,
                    items: const ['233','2','4567'],
                    onChanged: (value) {
                      selectedItemUnit = value;
                    }),
                fieldsTile(
                  "Name*",
                  "Enter Name",
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                fieldsTile(
                  "Phone Number*",
                  "Enter phone number",
                  controller: phoneNumberController,
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

                ),
                fieldsTile(
                  "Email*",
                  "Enter Email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Nationality*",style: AppTextStyles.style12Black600,)),
                const Gap(8),
                SingleSelectedDropdownWidget<String>(
                    hint: "Select ",
                    fillColor: AppColors.white,
                    selectedItem: selectedItemNationality,
                    compareFn: (p0, p1) => p0 == p1,
                    items: const ['pakistan','Australia',],
                    onChanged: (value) {
                      selectedItemNationality = value;

                    }),
                fieldsTile(
                  "Entry Card Number*",
                  "Enter card number ",
                  controller: cardNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ), fieldsTile(
                  "Description*",
                  "Enter description ",
                  controller: descriptionController,
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
        ),
        bottomNavigationBar:  const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.verticalPadding),
          child: LogoutButton(
            backgroundColor: AppColors.green,
            image: AppImages.checkInButton,
            text: "Check-In",
          ),
        ),
      ),
    );
  }

  Widget fieldsTile(
      String text,
      String hintText, {
        TextEditingController? controller,
        TextInputType? keyboardType,
        bool enabled = true,
        final Widget? suffix,
        List<TextInputFormatter>? inputFormatters,
        void Function()? onTap,
        String? Function(String?)? validator,
        bool obscureText = false,
        int? maxLength,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Text( text,style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AppColors.black
        ),
        ),
        const Gap(10),
        GestureDetector(
          //overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: onTap,
          child: TextFormField(
            enabled: enabled,
            maxLines: maxLength ?? 1,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: (inputFormatters?.isEmpty??true)?[RemoveEmojiInputFormatter()]:inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.gray, width: 1),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              counterText: "",
              suffixIcon: suffix,
              isDense: true,
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.darkGrey, fontSize: 13),
              fillColor: Colors.white,
              filled: true,
              errorStyle: const TextStyle(color: AppColors.red),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.gray, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.gray, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.gray, width: 1),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: AppColors.gray,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
