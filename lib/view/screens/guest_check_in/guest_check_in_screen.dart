import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:mrz_parser/mrz_parser.dart';
import 'package:path/path.dart' as path;
import 'package:visitors/bloc/guest_check_in/guest_check_in_cubit.dart';
import 'package:visitors/model/driving_license_model.dart';
import 'package:visitors/model/emirates_id_model.dart';
import 'package:visitors/model/ocr_model.dart';
import 'package:visitors/model/passport_model.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/screens/guest_check_in/components/get_info_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/picker/custom_date_picker.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../helper/mrz_helper.dart';
// import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../model/country/country_model.dart';
import '../../../model/unit/unit_model.dart';
import '../../../model/visitor_info/number_info_model.dart';
import '../../../model/visitor_info/visitors_purpose_model.dart';
import '../../widgets/button/custom_button.dart';

class GuestCheckInScreen extends StatefulWidget {
  const GuestCheckInScreen({super.key});

  @override
  State<GuestCheckInScreen> createState() => _GuestCheckInScreenState();
}

class _GuestCheckInScreenState extends State<GuestCheckInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneNumberKey = GlobalKey<FormState>();
  final TextEditingController _visitorCountController =
      TextEditingController(text: '1');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '971');
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _entryCardNumberController =
      TextEditingController();
  final TextEditingController _photoIdNumberController =
      TextEditingController();
  final TextEditingController _emiratesIdNumberController =
      TextEditingController();
  final TextEditingController _travelDocumentNumberController =
      TextEditingController();
  TypeItemModel? _selectedVisitType;
  DateTime? _selectedEmiratesIdIssueDate;
  DateTime? _selectedEmiratesIdExpiryDate;
  DateTime? _selectedPhotoIdIssueDate;
  DateTime? _selectedPhotoIdExpiryDate;
  DateTime? _selectedTravelDocumentIssueDate;
  DateTime? _selectedTravelDocumentExpiryDate;
  File? _personImage;
  TypeItemModel? _selectedDocumentType;


  final List<TypeItemModel> _documentTypes = [
    TypeItemModel(
      value: 'Emirates ID',
      label: AppUtils.languageTranslate('emiratesId'),
    ),
    TypeItemModel(
      value: 'Photo ID',
      label: AppUtils.languageTranslate('photoId'),
    ),
    TypeItemModel(
      value: 'Travel Document',
      label: AppUtils.languageTranslate('travelDocument'),
    ),
  ];
  final List<TypeItemModel> _visitTypes = [
    TypeItemModel(
      value: 'Unit Visit',
      label: AppUtils.languageTranslate('unitVisit'),
    ),
    TypeItemModel(
      value: 'Community Visit',
      label: AppUtils.languageTranslate('communityVisit'),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _selectedDocumentType = _documentTypes.first;
    _selectedVisitType = _visitTypes.first;
  }
  void clearData() {
    _personImage = null;
    _emiratesIdNumberController.clear();
    _photoIdNumberController.clear();
    _travelDocumentNumberController.clear();
    _selectedEmiratesIdIssueDate = null;
    _selectedEmiratesIdExpiryDate = null;
    _selectedPhotoIdIssueDate = null;
    _selectedPhotoIdExpiryDate = null;
    _selectedTravelDocumentIssueDate = null;
    _selectedTravelDocumentExpiryDate = null;
    context.read<GuestCheckInCubit>().onChangeSelectedNationality(Country());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarWidget(
          title: AppUtils.languageTranslate('guestCheckIn'),
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: width >= AppConstants.tabletScreen
            ? _tabletGuestCheckInScreen(context)
            : _mobileGuestCheckInScreen(context),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: BlocBuilder<GuestCheckInCubit, GuestCheckInState>(
            builder: (context, state) {
              return CustomButton(
                imageHeight: AppUtils.isTablet(context) ? 22 : 18,
                image: AppImages.checkInButton,
                buttonColor: AppColors.green,
                text: AppUtils.languageTranslate('checkIn'),
                onPressed: state.isGuestCheckInLoading
                    ? null
                    : () {
                        print(' state${state.selectedUnit?.id}');
                        if ((_formKey.currentState?.validate() ?? false) &&
                            (_phoneNumberKey.currentState?.validate() ??
                                false)) {
                          Map<String, dynamic> formData = {
                            if (_selectedDocumentType?.value ==
                                'Emirates ID') ...{
                              'id_number': _emiratesIdNumberController.text,
                              'id_issue_date':
                                  _selectedEmiratesIdIssueDate?.toString(),
                              'id_expiry_date':
                                  _selectedEmiratesIdExpiryDate?.toString(),
                            },
                            if (_selectedDocumentType?.value == 'Photo ID') ...{
                              'photo_id_number': _photoIdNumberController.text,
                              'photo_id_issue_date':
                                  _selectedPhotoIdIssueDate?.toString(),
                              'photo_id_expiry_date':
                                  _selectedPhotoIdExpiryDate?.toString(),
                            },
                            if (_selectedDocumentType?.value == 'Photo ID') ...{
                              'passport_number':
                                  _travelDocumentNumberController.text,
                              'passport_issue_date':
                                  _selectedTravelDocumentIssueDate?.toString(),
                              'passport_expiry_date':
                                  _selectedTravelDocumentExpiryDate?.toString(),
                            },
                            'type': _selectedVisitType?.value,
                            'name': _nameController.text,
                            if (_selectedVisitType?.value == 'Unit Visit') ...{
                              'purpose': state.selectedPurpose?.purpose,
                              'unit_id': state.selectedUnit?.id,
                              'unit_number': state.selectedUnit?.toJson(),
                            },
                            'phone': _phoneNumberController.text,
                            'email': _emailController.text,
                            'entry_card_number':
                                _entryCardNumberController.text,
                            'nationality': state.selectedNationality?.name,
                            'description': _descriptionController.text,
                            'serviceable_id': null,
                            'serviceable_type': null,
                            'sms': false,
                            'visitor_count': _visitorCountController.text,
                            'visitor_id': null,
                          };
                          context
                              .read<GuestCheckInCubit>()
                              .guestCheckIn(context, data: formData);
                        }
                      },
                loading: state.isGuestCheckInLoading,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _tabletGuestCheckInScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: BlocBuilder<GuestCheckInCubit, GuestCheckInState>(
            builder: (ctx, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.darkGrey),
                      ),
                      child: (_personImage?.path.isNotEmpty ?? false)
                          ? Image.file(
                              _personImage!,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              Icons.person_outline_rounded,
                              size: MediaQuery.of(context).size.width / 4,
                            ),
                    ),
                  ),
                  const Gap(25),
                  CustomButton(
                    buttonColor: AppColors.primary,
                    text: _selectedDocumentType?.value == 'Emirates ID'
                        ? AppUtils.languageTranslate('scanEmiratesId')
                        : _selectedDocumentType?.value == 'Photo ID'
                            ? AppUtils.languageTranslate('scanPhotoId')
                            : AppUtils.languageTranslate('scanTravelDocument'),
                    fontSize: 20,
                    height: 60,
                    imageHeight: 25,
                    borderRadius: 6,
                    image: AppImages.scan,
                    onPressed: () {
                      if (_selectedDocumentType?.value == 'Emirates ID') {
                        _onScanEmiratesIdTap();
                      } else if (_selectedDocumentType?.value == 'Photo ID') {
                        _onScanDrivingLicenseTap();
                      } else {
                        _onScanPassportTap(context);
                      }
                      // showDialog(
                      //     context: context,
                      //     builder: (ctx) {
                      //       return CustomAlertDialogBox(
                      //         insetPadding: AppUtils.isTablet(context)
                      //             ? EdgeInsets.all(70)
                      //             : EdgeInsets.all(10),
                      //         hideBothButtons: true,
                      //         title: AppUtils.languageTranslate('selectType'),
                      //         contentBuilder: (ctx, setState) {
                      //           return Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Text('Select any ID type for Scan',
                      //                   style: AppUtils.isTablet(context)
                      //                       ? AppTextStyles.style16black600
                      //                       : AppTextStyles.style14Black600),
                      //               Gap(20),
                      //               Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     horizontal: 0, vertical: 20),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     ScanTypeContainerWidget(
                      //                       text: AppUtils.languageTranslate(
                      //                           'emiratesId'),
                      //                       textSize: 16,
                      //                       iconSize: 30,
                      //                       padding: 10,
                      //                       heightContainer: 110,
                      //                       widthContainer: 110,
                      //                       onTap: () {
                      //                         _onScanEmiratesIdTap();
                      //                       },
                      //                     ),
                      //                     ScanTypeContainerWidget(
                      //                       text: AppUtils.languageTranslate(
                      //                           'passport'),
                      //                       textSize: 16,
                      //                       iconSize: 30,
                      //                       padding: 10,
                      //                       heightContainer: 110,
                      //                       widthContainer: 110,
                      //                       onTap: () {
                      //                         _onScanPassportTap(context);
                      //                       },
                      //                     ),
                      //                     ScanTypeContainerWidget(
                      //                       text: AppUtils.languageTranslate(
                      //                           'drivingLicense'),
                      //                       textSize: 16,
                      //                       iconSize: 30,
                      //                       padding: 10,
                      //                       heightContainer: 110,
                      //                       widthContainer: 110,
                      //                       onTap: () {
                      //                         _onScanDrivingLicenseTap();
                      //                       },
                      //                     ),
                      //                   ],
                      //                 ),
                      //               )
                      //             ],
                      //           );
                      //         },
                      //       );
                      //     });
                    },
                  ),
                  const Gap(25),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleSelectedDropdownWidget<TypeItemModel>(
                          label: AppUtils.languageTranslate('type'),
                          hint: AppUtils.languageTranslate('selectType'),
                          isClearButtonVisible: false,
                          fillColor: AppColors.white,
                          selectedItem: _selectedDocumentType,
                          compareFn: (p0, p1) => p0.value == p1.value,
                          items: _documentTypes,
                          itemAsString: (item) => item.label,
                          onChanged: (value) {
                            _selectedDocumentType = value;
                            clearData();
                          },
                          validator: (value) {
                            if (value == null) {
                              return AppUtils.languageTranslate('required');
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        if (_selectedDocumentType?.value == 'Emirates ID')
                          TextFieldWidget(
                            outLineColor: AppColors.outLineGray,
                            enabledBorder: InputBorder.none,
                            controller: _emiratesIdNumberController,
                            label: AppUtils.languageTranslate('emiratesId'),
                            hint: AppUtils.languageTranslate('enterNumber'),
                            keyboardType: TextInputType.text,
                          ),
                        if (_selectedDocumentType?.value == 'Photo ID')
                          TextFieldWidget(
                            outLineColor: AppColors.outLineGray,
                            enabledBorder: InputBorder.none,
                            controller: _photoIdNumberController,
                            label: AppUtils.languageTranslate('photoId'),
                            hint: AppUtils.languageTranslate('enterNumber'),
                            keyboardType: TextInputType.text,
                          ),
                        if (_selectedDocumentType?.value == 'Travel Document')
                          TextFieldWidget(
                            outLineColor: AppColors.outLineGray,
                            enabledBorder: InputBorder.none,
                            controller: _travelDocumentNumberController,
                            label: AppUtils.languageTranslate('travelDocument'),
                            hint: AppUtils.languageTranslate('enterNumber'),
                            keyboardType: TextInputType.text,
                          ),
                        const Gap(5),
                        if (_selectedDocumentType?.value == 'Emirates ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('issueDate'),
                            hint: AppUtils.languageTranslate('selectIssueDate'),
                            initialDate: _selectedEmiratesIdIssueDate,
                            onDatePicked: (value) {
                              _selectedEmiratesIdIssueDate = value;
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Photo ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('issueDate'),
                            hint: AppUtils.languageTranslate('selectIssueDate'),
                            initialDate: _selectedPhotoIdIssueDate,
                            onDatePicked: (value) {
                              _selectedPhotoIdIssueDate = value;
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Travel Document')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('issueDate'),
                            hint: AppUtils.languageTranslate('selectIssueDate'),
                            initialDate: _selectedTravelDocumentIssueDate,
                            onDatePicked: (value) {
                              _selectedTravelDocumentIssueDate = value;
                            },
                          ),
                        const Gap(5),
                        if (_selectedDocumentType?.value == 'Emirates ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('expiryDate'),
                            hint:
                                AppUtils.languageTranslate('selectExpiryDate'),
                            initialDate: _selectedEmiratesIdExpiryDate,
                            onDatePicked: (value) {
                              _selectedEmiratesIdExpiryDate = value;
                              //print('Selected Date: $value');
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Photo ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('expiryDate'),
                            hint:
                                AppUtils.languageTranslate('selectExpiryDate'),
                            initialDate: _selectedPhotoIdExpiryDate,
                            onDatePicked: (value) {
                              _selectedPhotoIdExpiryDate = value;
                              //print('Selected Date: $value');
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Travel Document')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('expiryDate'),
                            hint:
                                AppUtils.languageTranslate('selectExpiryDate'),
                            initialDate: _selectedTravelDocumentExpiryDate,
                            onDatePicked: (value) {
                              _selectedTravelDocumentExpiryDate = value;
                              //print('Selected Date: $value');
                            },
                          ),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child:
                                  SingleSelectedDropdownWidget<TypeItemModel>(
                                label: "${AppUtils.languageTranslate('type')}*",
                                isClearButtonVisible: false,
                                outLineColor: AppColors.outLineGray,
                                hint: AppUtils.languageTranslate('selectType'),
                                fillColor: AppColors.white,
                                selectedItem: _selectedVisitType,
                                compareFn: (p0, p1) => p0.value == p1.value,
                                items: _visitTypes,
                                itemAsString: (item) => item.label,
                                onChanged: (value) {
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    setState(() {
                                      _selectedVisitType = value;
                                    });
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return AppUtils.languageTranslate(
                                        'required');
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: TextFieldWidget(
                                controller: _visitorCountController,
                                label:
                                    '${AppUtils.languageTranslate('visitorCount')}*',
                                hint: AppUtils.languageTranslate('enterCount'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppUtils.languageTranslate(
                                        'required');
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        if (_selectedVisitType?.value ==
                            AppUtils.languageTranslate('unitVisit')) ...[
                          Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleSelectedDropdownWidget<
                                    VisitorsPurpose>(
                                  label:
                                      "${AppUtils.languageTranslate('purpose')}*",
                                  hint: AppUtils.languageTranslate(
                                      'selectPurpose'),
                                  fillColor: AppColors.white,
                                  selectedItem: state.selectedPurpose,
                                  itemAsString: (purpose) =>
                                      purpose.purpose ?? "",
                                  compareFn: (p0, p1) => p0.id == p1.id,
                                  items: state.profileRecord?.association
                                          ?.visitorsPurposes ??
                                      [],
                                  onChanged: (value) {
                                    context
                                        .read<GuestCheckInCubit>()
                                        .onChangeSelectedPurpose(value);
                                  },
                                  validator: (value) {
                                    if (value?.purpose?.isEmpty ?? true) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Gap(8),
                              Expanded(
                                child: SingleSelectedDropdownWidget<UnitModel>(
                                  label:
                                      "${AppUtils.languageTranslate('unitNumber')}*",
                                  hint: AppUtils.languageTranslate('unit'),
                                  fillColor: AppColors.white,
                                  selectedItem: state.selectedUnit,
                                  itemAsString: (unit) => unit.unitNumber ?? "",
                                  compareFn: (unit, item) => unit.id == item.id,
                                  items: state.units ?? [],
                                  onChanged: (value) {
                                    context
                                        .read<GuestCheckInCubit>()
                                        .onChangeSelectedUnit(value);
                                  },
                                  validator: (value) {
                                    if (value?.unitNumber?.isEmpty ?? true) {
                                      return AppUtils.languageTranslate(
                                          'required');
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                        const Gap(5),
                        TextFieldWidget(
                          enabledBorder: InputBorder.none,
                          controller: _nameController,
                          label: '${AppUtils.languageTranslate('name')}*',
                          hint: AppUtils.languageTranslate('enterName'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppUtils.languageTranslate('required');
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        Form(
                          key: _phoneNumberKey,
                          child: TextFieldWidget(
                            label:
                                "${AppUtils.languageTranslate('phoneNumber')}*",
                            hint:
                                AppUtils.languageTranslate('enterPhoneNumber'),
                            controller: _phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppUtils.languageTranslate(
                                    'requiredMax13Digits');
                              }
                              if (!RegExp(r'^\d{7,13}$').hasMatch(value)) {
                                return AppUtils.languageTranslate(
                                    'enterValidMobileNumber');
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(13),
                            ],
                            suffix: Container(
                              width: 80,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  border: Border.all(color: AppColors.primary)),
                              child: state.isNumberInfoLoading
                                  ? LoaderWidget()
                                  : TextButton(
                                      style: ButtonStyle(
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      onPressed: () {
                                        _onGetInfoPressed(context);
                                      },
                                      child: Text(
                                        AppUtils.languageTranslate('getInfo'),
                                        style: TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldWidget(
                                controller: _emailController,
                                label: AppUtils.languageTranslate('email'),
                                hint: AppUtils.languageTranslate('enterEmail'),
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: SingleSelectedDropdownWidget<Country>(
                                label:
                                    AppUtils.languageTranslate('nationality'),
                                outLineColor: AppColors.outLineGray,
                                hint: AppUtils.languageTranslate(
                                    'selectNationality'),
                                fillColor: AppColors.white,
                                selectedItem: context
                                    .watch<GuestCheckInCubit>()
                                    .state
                                    .selectedNationality,
                                items: state.countries ?? [],
                                itemAsString: (country) => country.name ?? "",
                                compareFn: (p0, p1) => p0.id == p1.id,
                                onChanged: (value) {
                                  context
                                      .read<GuestCheckInCubit>()
                                      .onChangeSelectedNationality(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          controller: _entryCardNumberController,
                          label: AppUtils.languageTranslate('entryCardNumber'),
                          hint: AppUtils.languageTranslate('enterCardNumber'),
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          controller: _descriptionController,
                          label: AppUtils.languageTranslate('description'),
                          hint: AppUtils.languageTranslate('enterDescription'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _mobileGuestCheckInScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: BlocBuilder<GuestCheckInCubit, GuestCheckInState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.width / 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.darkGrey),
                      ),
                      child: (_personImage?.path.isNotEmpty ?? false)
                          ? Image.file(
                              _personImage!,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              Icons.person_outline_rounded,
                              size: MediaQuery.of(context).size.width / 4,
                            ),
                    ),
                  ),
                  const Gap(20),
                  CustomButton(
                    buttonColor: AppColors.primary,
                    text: _selectedDocumentType?.value == 'Emirates ID'
                        ? AppUtils.languageTranslate('scanEmiratesId')
                        : _selectedDocumentType?.value == 'Photo ID'
                            ? AppUtils.languageTranslate('scanPhotoId')
                            : AppUtils.languageTranslate('scanTravelDocument'),
                    height: 41,
                    borderRadius: 6,
                    image: AppImages.scan,
                    onPressed: () {
                      if (_selectedDocumentType?.value == 'Emirates ID') {
                        _onScanEmiratesIdTap();
                      } else if (_selectedDocumentType?.value == 'Photo ID') {
                        _onScanDrivingLicenseTap();
                      } else {
                        _onScanPassportTap(context);
                      }
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return CustomAlertDialogBox(
                      //       insetPadding: EdgeInsets.all(10),
                      //       hideBothButtons: true,
                      //       title: AppUtils.languageTranslate('selectType'),
                      //       contentBuilder: (context, setState) {
                      //         return Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 ScanTypeContainerWidget(
                      //                   text: AppUtils.languageTranslate(
                      //                       'emiratesId'),
                      //                   onTap: () {
                      //                     _onScanEmiratesIdTap();
                      //                   },
                      //                 ),
                      //                 ScanTypeContainerWidget(
                      //                   text: AppUtils.languageTranslate(
                      //                       'passport'),
                      //                   onTap: () {
                      //                     _onScanPassportTap(context);
                      //                   },
                      //                 ),
                      //                 ScanTypeContainerWidget(
                      //                   text: AppUtils.languageTranslate(
                      //                       'drivingLicense'),
                      //                   onTap: () {
                      //                     _onScanDrivingLicenseTap();
                      //                   },
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //   },
                      // );
                    },
                  ),
                  const Gap(20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleSelectedDropdownWidget<TypeItemModel>(
                          label: AppUtils.languageTranslate('type'),
                          hint: AppUtils.languageTranslate('selectType'),
                          isClearButtonVisible: false,
                          fillColor: AppColors.white,
                          selectedItem: _selectedDocumentType,
                          compareFn: (p0, p1) => p0.value == p1.value,
                          items: _documentTypes,
                          itemAsString: (item) => item.label,
                          onChanged: (value) {
                            _selectedDocumentType = value;
                            clearData();
                          },
                          validator: (value) {
                            if (value == null) {
                              return AppUtils.languageTranslate('required');
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        if (_selectedDocumentType?.value == 'Emirates ID')
                          TextFieldWidget(
                            outLineColor: AppColors.outLineGray,
                            enabledBorder: InputBorder.none,
                            controller: _emiratesIdNumberController,
                            label: AppUtils.languageTranslate('emiratesId'),
                            hint: AppUtils.languageTranslate('enterNumber'),
                            keyboardType: TextInputType.text,
                          ),
                        if (_selectedDocumentType?.value == 'Photo ID')
                          TextFieldWidget(
                            outLineColor: AppColors.outLineGray,
                            enabledBorder: InputBorder.none,
                            controller: _photoIdNumberController,
                            label: AppUtils.languageTranslate('photoId'),
                            hint: AppUtils.languageTranslate('enterNumber'),
                            keyboardType: TextInputType.text,
                          ),
                        if (_selectedDocumentType?.value == 'Travel Document')
                          TextFieldWidget(
                            outLineColor: AppColors.outLineGray,
                            enabledBorder: InputBorder.none,
                            controller: _travelDocumentNumberController,
                            label: AppUtils.languageTranslate('travelDocument'),
                            hint: AppUtils.languageTranslate('enterNumber'),
                            keyboardType: TextInputType.text,
                          ),
                        const Gap(5),
                        if (_selectedDocumentType?.value == 'Emirates ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('issueDate'),
                            hint: AppUtils.languageTranslate('selectIssueDate'),
                            initialDate: _selectedEmiratesIdIssueDate,
                            onDatePicked: (value) {
                              _selectedEmiratesIdIssueDate = value;
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Photo ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('issueDate'),
                            hint: AppUtils.languageTranslate('selectIssueDate'),
                            initialDate: _selectedPhotoIdIssueDate,
                            onDatePicked: (value) {
                              _selectedPhotoIdIssueDate = value;
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Travel Document')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('issueDate'),
                            hint: AppUtils.languageTranslate('selectIssueDate'),
                            initialDate: _selectedTravelDocumentIssueDate,
                            onDatePicked: (value) {
                              _selectedTravelDocumentIssueDate = value;
                            },
                          ),
                        const Gap(5),
                        if (_selectedDocumentType?.value == 'Emirates ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('expiryDate'),
                            hint:
                                AppUtils.languageTranslate('selectExpiryDate'),
                            initialDate: _selectedEmiratesIdExpiryDate,
                            onDatePicked: (value) {
                              _selectedEmiratesIdExpiryDate = value;
                              //print('Selected Date: $value');
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Photo ID')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('expiryDate'),
                            hint:
                                AppUtils.languageTranslate('selectExpiryDate'),
                            initialDate: _selectedPhotoIdExpiryDate,
                            onDatePicked: (value) {
                              _selectedPhotoIdExpiryDate = value;
                              //print('Selected Date: $value');
                            },
                          ),
                        if (_selectedDocumentType?.value == 'Travel Document')
                          CustomDatePicker(
                            label: AppUtils.languageTranslate('expiryDate'),
                            hint:
                                AppUtils.languageTranslate('selectExpiryDate'),
                            initialDate: _selectedTravelDocumentExpiryDate,
                            onDatePicked: (value) {
                              _selectedTravelDocumentExpiryDate = value;
                              //print('Selected Date: $value');
                            },
                          ),
                        const Gap(5),
                        SingleSelectedDropdownWidget<TypeItemModel>(
                          label: "${AppUtils.languageTranslate('type')}*",
                          isClearButtonVisible: false,
                          outLineColor: AppColors.outLineGray,
                          hint: AppUtils.languageTranslate('selectType'),
                          fillColor: AppColors.white,
                          selectedItem: _selectedVisitType,
                          compareFn: (p0, p1) => p0.value == p1.value,
                          items: _visitTypes,
                          itemAsString: (item) => item.label,
                          onChanged: (value) {
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                _selectedVisitType = value;
                              });
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return AppUtils.languageTranslate('required');
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.outLineGray,
                          controller: _visitorCountController,
                          label:
                              '${AppUtils.languageTranslate('visitorCount')}*',
                          hint: AppUtils.languageTranslate('enterCount'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppUtils.languageTranslate('required');
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        if (_selectedVisitType?.value ==
                            AppUtils.languageTranslate('unitVisit')) ...[
                          SingleSelectedDropdownWidget<VisitorsPurpose>(
                            label: "${AppUtils.languageTranslate('purpose')}*",
                            hint: AppUtils.languageTranslate('selectPurpose'),
                            fillColor: AppColors.white,
                            outLineColor: AppColors.outLineGray,
                            selectedItem: state.selectedPurpose,
                            itemAsString: (purpose) => purpose.purpose ?? "",
                            compareFn: (p0, p1) => p0.id == p1.id,
                            items: state.profileRecord?.association
                                    ?.visitorsPurposes ??
                                [],
                            onChanged: (value) {
                              context
                                  .read<GuestCheckInCubit>()
                                  .onChangeSelectedPurpose(value);
                            },
                            validator: (value) {
                              if (value?.purpose?.isEmpty ?? true) {
                                return AppUtils.languageTranslate('required');
                              }
                              return null;
                            },
                          ),
                          const Gap(5),
                          SingleSelectedDropdownWidget<UnitModel>(
                            label:
                                "${AppUtils.languageTranslate('unitNumber')}*",
                            outLineColor: AppColors.outLineGray,
                            hint: AppUtils.languageTranslate('unit'),
                            fillColor: AppColors.white,
                            selectedItem: state.selectedUnit,
                            itemAsString: (unit) => unit.unitNumber ?? "",
                            compareFn: (unit, item) => unit.id == item.id,
                            items: state.units ?? [],
                            onChanged: (value) {
                              print('value::: ${value?.toJson()}');
                              context
                                  .read<GuestCheckInCubit>()
                                  .onChangeSelectedUnit(value);
                              print('state value:: ${state.selectedUnit?.id}');
                            },
                            validator: (value) {
                              if (value?.unitNumber?.isEmpty ?? true) {
                                return AppUtils.languageTranslate('required');
                              }
                              return null;
                            },
                          ),
                        ],
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.outLineGray,
                          enabledBorder: InputBorder.none,
                          controller: _nameController,
                          label: '${AppUtils.languageTranslate('name')}*',
                          hint: AppUtils.languageTranslate('enterName'),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppUtils.languageTranslate('required');
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        Form(
                          key: _phoneNumberKey,
                          child: TextFieldWidget(
                            outLineColor: AppColors.gray,
                            label:
                                "${AppUtils.languageTranslate('phoneNumber')}*",
                            hint: "+971",
                            controller: _phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppUtils.languageTranslate(
                                    'requiredMax13Digits');
                              }
                              if (!RegExp(r'^\d{7,13}$').hasMatch(value)) {
                                return AppUtils.languageTranslate(
                                    'enterValidMobileNumber');
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(13),
                            ],
                            suffix: Container(
                              width: 80,
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  border: Border.all(color: AppColors.primary)),
                              child: state.isNumberInfoLoading
                                  ? LoaderWidget()
                                  : TextButton(
                                      style: ButtonStyle(
                                        overlayColor: WidgetStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      onPressed: () {
                                        _onGetInfoPressed(context);
                                      },
                                      child: Text(
                                          AppUtils.languageTranslate('getInfo'),
                                          style: TextStyle(
                                              color: AppColors.primary)),
                                    ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.gray,
                          controller: _emailController,
                          label: AppUtils.languageTranslate('email'),
                          hint: AppUtils.languageTranslate('enterEmail'),
                        ),
                        const Gap(5),
                        SingleSelectedDropdownWidget<Country>(
                          label: AppUtils.languageTranslate('nationality'),
                          outLineColor: AppColors.outLineGray,
                          hint:
                              AppUtils.languageTranslate('unitedArabEmirates'),
                          fillColor: AppColors.white,
                          selectedItem: context
                              .watch<GuestCheckInCubit>()
                              .state
                              .selectedNationality,
                          items: state.countries ?? [],
                          itemAsString: (country) => country.name ?? "",
                          compareFn: (p0, p1) => p0.id == p1.id,
                          onChanged: (value) {
                            context
                                .read<GuestCheckInCubit>()
                                .onChangeSelectedNationality(value);
                          },
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.gray,
                          controller: _entryCardNumberController,
                          label: AppUtils.languageTranslate('entryCardNumber'),
                          hint: AppUtils.languageTranslate('enterCardNumber'),
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.gray,
                          controller: _descriptionController,
                          label: AppUtils.languageTranslate('description'),
                          hint: AppUtils.languageTranslate('enterDescription'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onGetInfoPressed(BuildContext context) async {
    if (!(_phoneNumberKey.currentState?.validate() ?? false)) {
      return;
    }
    final phoneNumber = _phoneNumberController.text.trim();
    await context
        .read<GuestCheckInCubit>()
        .getNumberInfo(phoneNumber: phoneNumber);
    if (!context.mounted) return;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return CustomAlertDialogBox(
          hideBothButtons: true,
          insetPadding: AppUtils.isTablet(context)
              ? const EdgeInsets.symmetric(horizontal: 35)
              : const EdgeInsets.symmetric(horizontal: 10),
          title: AppUtils.languageTranslate('selectVisitor'),
          contentBuilder: (context, setState) {
            return _visitorNumberWidget(
              _phoneNumberController.text,
              remainingVisitors: ((context
                          .read<GuestCheckInCubit>()
                          .state
                          .numberInfo
                          ?.length ??
                      0) -
                  1),
            );
          },
        );
      },
    );
  }

  Widget _visitorNumberWidget(String phoneNumber, {int? remainingVisitors}) {
    return BlocBuilder<GuestCheckInCubit, GuestCheckInState>(
      builder: (context, state) {
        if (state.isNumberInfoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.numberInfo?.isEmpty ?? true) {
          return Center(
            child: Text(
              AppUtils.languageTranslate('noVisitorRecordsFound'),
              style: AppTextStyles.style14DarkGrey600,
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${state.numberInfo?.length}",
              style: AppTextStyles.style36Blue500,
            ),
            Text(
              AppUtils.languageTranslate('visitorRecordsFound'),
              style: AppUtils.isMobile(context)
                  ? AppTextStyles.style14Black600
                  : AppTextStyles.style15Black600,
            ),
            const Divider(
              color: AppColors.lightGrey,
            ),
            const Gap(5),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: state.numberInfo?.length ?? 0,
                itemBuilder: (context, index) {
                  NumberInfo? numberInfo = state.numberInfo?[index];
                  return GetInfoCardWidget(
                    deleteOnPressed: () async {
                      return context.read<GuestCheckInCubit>().deleteVisitor(
                            context,
                            id: numberInfo?.id,
                            phoneNumber: phoneNumber,
                            // remainingVisitors: remainingVisitors,
                          );
                    },
                    name: numberInfo?.name ?? '',
                    nationality: numberInfo?.nationality ?? '',
                    profileImageUrl: numberInfo?.imageUrl ?? '',
                    onSelectPressed: () {
                      _nameController.text = numberInfo?.name ?? '';
                      _emailController.text = numberInfo?.email ?? '';
                      _emiratesIdNumberController.text =
                          numberInfo?.idNumber ?? '';
                      _photoIdNumberController.text =
                          numberInfo?.photoIdNumber ?? '';
                      _travelDocumentNumberController.text =
                          numberInfo?.passportNumber ?? '';

                      _selectedEmiratesIdIssueDate =
                          DateTime.tryParse(numberInfo?.idIssueDate ?? '');
                      _selectedEmiratesIdExpiryDate =
                          DateTime.tryParse(numberInfo?.idExpiryDate ?? '');
                      _selectedPhotoIdIssueDate =
                          DateTime.tryParse(numberInfo?.photoIdIssueDate ?? '');
                      _selectedPhotoIdExpiryDate = DateTime.tryParse(
                          numberInfo?.photoIdExpiryDate ?? '');
                      _selectedTravelDocumentIssueDate = DateTime.tryParse(
                          numberInfo?.passportIssueDate ?? '');
                      _selectedTravelDocumentExpiryDate = DateTime.tryParse(
                          numberInfo?.passportExpiryDate ?? '');
                      _selectedPhotoIdExpiryDate = DateTime.tryParse(
                          numberInfo?.photoIdExpiryDate ?? '');
                      _selectedTravelDocumentIssueDate = DateTime.tryParse(
                          numberInfo?.passportIssueDate ?? '');
                      _selectedTravelDocumentExpiryDate = DateTime.tryParse(
                          numberInfo?.passportExpiryDate ?? '');

                      if (numberInfo?.nationality?.isNotEmpty ?? false) {
                        List<Country>? countries =
                            context.read<GuestCheckInCubit>().state.countries;
                        final Country? matchedCountry = countries?.firstWhere(
                          (item) =>
                              item.name?.toLowerCase() ==
                              numberInfo?.nationality?.toLowerCase(),
                          orElse: () => Country(),
                        );

                        if (matchedCountry?.id != null) {}
                        context
                            .read<GuestCheckInCubit>()
                            .onChangeSelectedNationality(matchedCountry);
                      }
                    },
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
      },
    );
  }

  void _onScanPassportTap(BuildContext context) {
    _scanMrzForPassportAndParse(context);
    // _scanPassportAndPerformOcr();
  }

  void _onScanEmiratesIdTap() {
    _scanEmiratesIdAndPerformOcr();
  }

  void _onScanDrivingLicenseTap() {
    _scanDrivingLicenseAndPerformOcr();
  }

  Future<void> _scanEmiratesIdAndPerformOcr() async {
    EmiratesIdModel? emiratesIdData;
    OcrModel? ocrData = await _scanDocumentAndPerformOCR();
    String? recognizedText;
    if (ocrData != null) {
      recognizedText = ocrData.recognizedTExt;
      // print(' EmiratesId Text: $recognizedText');

      final scannedText = recognizedText?.toLowerCase() ?? '';
      if (!scannedText.toLowerCase().contains('id number')) {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
        return;
      }
      if (recognizedText?.isNotEmpty ?? false) {
        final Map<String, String> parsedText =
            _parseEmiratesIdExtractedText(recognizedText!);

        emiratesIdData = EmiratesIdModel(
          personImage: ocrData.personImage,
          name: parsedText['Name'] ?? '',
          idNumber: parsedText['ID Number'] ?? '',
          issueDate: parsedText['Issuing Date'] ?? '',
          expiryDate: parsedText['Expiry Date'] ?? '',
          nationality: parsedText['Nationality'] ?? parsedText['nationality'],
        );

        clearData();

        setState(() {
          _personImage = emiratesIdData?.personImage;
          _nameController.text = emiratesIdData?.name ?? '';
          _emiratesIdNumberController.text = emiratesIdData?.idNumber ?? '';
          DateFormat format = DateFormat('dd/MM/yyyy');
          _selectedEmiratesIdIssueDate =
              format.tryParse(emiratesIdData?.issueDate ?? '');
          _selectedEmiratesIdExpiryDate =
              format.tryParse(emiratesIdData?.expiryDate ?? '');
          List<Country>? countries =
              context.read<GuestCheckInCubit>().state.countries;
          if ((emiratesIdData?.nationality?.isNotEmpty ?? false) &&
              (countries?.isNotEmpty ?? false)) {
            final normalized =
                emiratesIdData?.nationality?.trim().toLowerCase();

            final Country? matchedCountry = countries?.firstWhere(
              (item) => item.name?.toLowerCase() == normalized,
              orElse: () => Country(),
            );

            if (matchedCountry?.id != null) {
              context
                  .read<GuestCheckInCubit>()
                  .onChangeSelectedNationality(matchedCountry);
            }
          }
        });
      }
    }
  }

  Future<void> _scanDrivingLicenseAndPerformOcr() async {
    OcrModel? ocrData = await _scanDocumentAndPerformOCR();
    String? recognizedText;
    if (ocrData != null) {
      recognizedText = ocrData.recognizedTExt;

      final scannedText = recognizedText?.toLowerCase() ?? '';
      if (!scannedText.contains('driving')) {
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
        return;
      }

      if (recognizedText?.isNotEmpty ?? false) {
        DrivingLicenseModel? drivingLicenseData =
            _parseDrivingLicenseExtractedText(
                recognizedText!, ocrData.personImage);
        clearData();
        setState(() {
          _personImage = drivingLicenseData.personImage;
          _nameController.text = drivingLicenseData.name ?? '';
          _photoIdNumberController.text =
              drivingLicenseData.licenseNumber ?? '';
          // DateFormat format = DateFormat('dd/MM/yyyy');
          // _selectedPhotoIdIssueDate =
          //     format.tryParse(drivingLicenseData.issueDate ?? '');
          _selectedPhotoIdIssueDate = drivingLicenseData.issueDate != null
              ? DateTime.tryParse(drivingLicenseData.issueDate!)
              : null;
          _selectedPhotoIdExpiryDate = drivingLicenseData.expiryDate != null
              ? DateTime.tryParse(drivingLicenseData.expiryDate!)
              : null;
          // _selectedPhotoIdExpiryDate =
          //     format.tryParse(drivingLicenseData.expiryDate ?? '');
          List<Country>? countries =
              context.read<GuestCheckInCubit>().state.countries;
          if ((drivingLicenseData.nationality?.isNotEmpty ?? false) &&
              (countries?.isNotEmpty ?? false)) {
            final normalized =
                drivingLicenseData.nationality?.trim().toLowerCase();

            final Country? matchedCountry = countries?.firstWhere(
              (item) => item.name?.toLowerCase() == normalized,
              orElse: () => Country(),
            );

            if (matchedCountry?.id != null) {
              context
                  .read<GuestCheckInCubit>()
                  .onChangeSelectedNationality(matchedCountry);
            }
          }
        });
      }
    }
  }

  Future<void> _scanMrzForPassportAndParse(BuildContext context) async {
    final DocumentScannerOptions documentOptions = DocumentScannerOptions(
      documentFormat: DocumentFormat.jpeg,
      mode: ScannerMode.full,
      pageLimit: 1,
      isGalleryImport: false,
    );
    final documentScanner = DocumentScanner(options: documentOptions);
    DocumentScanningResult result = await documentScanner.scanDocument();
    File? scannedImageFile;
    final List<String> images = result.images;
    if (images.isNotEmpty && images.first.isNotEmpty) {
      scannedImageFile = File(images.first);
      final path = images.first;
      final inputImage = InputImage.fromFilePath(path);

      final textRecognizer = TextRecognizer();
      final visionText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();
      FaceDetector faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          performanceMode: FaceDetectorMode.accurate,
          minFaceSize: 1,
        ),
      );
      final List<Face> faces = await faceDetector.processImage(inputImage);
      final File? extractedPersonImage =
          _extractPersonImage(scannedImageFile, faces);
      faceDetector.close();

      final rawLines = visionText.text
          .replaceAll(' ', '')
          .split('\n')
          .where((line) => MRZHelper.testTextLine(line).isNotEmpty)
          .map((line) => MRZHelper.testTextLine(line))
          .toList();

      final mrzLines = MRZHelper.getFinalListToParse(rawLines);

      if (mrzLines != null) {
        final result = MRZParser.parse(mrzLines);
        PassportModel passportData = PassportModel(
          personImage: extractedPersonImage,
          name: result.givenNames,
          passportNumber: result.documentNumber,
          issueDate: result.expiryDate.toString(),
          expiryDate: result.expiryDate.toString(),
          nationality:
              AppUtils.getNationalityName(result.nationalityCountryCode),
        );
        //  print('document type:: ${result.documentType}');
        if (result.documentType.toLowerCase() != 'p') {
          Fluttertoast.showToast(
              msg: 'The scanned document is not a Passport.');
          return;
        }
        clearData();

        setState(() {
          _personImage = passportData.personImage;
          _nameController.text = passportData.name ?? '';
          _travelDocumentNumberController.text =
              passportData.passportNumber ?? '';
          _selectedTravelDocumentExpiryDate =
              DateTime.tryParse(passportData.expiryDate ?? '');
          List<Country>? countries =
              context.read<GuestCheckInCubit>().state.countries;
          if ((passportData.nationality?.isNotEmpty ?? false) &&
              (countries?.isNotEmpty ?? false)) {
            final normalized = passportData.nationality?.trim().toLowerCase();

            final Country? matchedCountry = countries?.firstWhere(
              (item) => item.name?.toLowerCase() == normalized,
              orElse: () => Country(),
            );

            if (matchedCountry?.id != null) {
              context
                  .read<GuestCheckInCubit>()
                  .onChangeSelectedNationality(matchedCountry);
            }
          }
        });

        // Show dialog or update UI
        // showDialog(
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: Text('MRZ Details'),
        //     content: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         if (extractedPersonImage?.path.isNotEmpty ?? false);
        //           Image.file(extractedPersonImage!),
        //         Text('Name: ${result.givenNames}'),
        //         Text('Surname: ${result.surnames}'),
        //         Text('Sex: ${result.sex}'),
        //         Text('Document Number: ${result.documentNumber}'),
        //         Text('Birth Date: ${result.birthDate}'),
        //         Text('Expiry Date: ${result.expiryDate}'),
        //         Text(
        //             'Nationality: ${AppUtils.getNationalityName(result.nationalityCountryCode)}'),
        //         Text('Type: ${result.documentType}'),
        //       ],
        //     ),
        //     actions: [
        //       TextButton(
        //         onPressed: () => Navigator.pop(context),
        //         child: Text('Close'),
        //       ),
        //     ],
        //   ),
        // );
      } else {
        debugPrint('No valid MRZ detected.');
        Fluttertoast.showToast(
            msg: AppUtils.languageTranslate(
                'scannedDocumentNotValidPleaseTryAgainUsingAValidDocument'));
      }
    }
  }

  Future<void> _scanPassportAndPerformOcr() async {
    OcrModel? ocrData = await _scanDocumentAndPerformOCR();
    File? personImage;
    String? recognizedText;
    if (ocrData != null) {
      personImage = ocrData.personImage;
      recognizedText = ocrData.recognizedTExt;
      if (personImage != null) {
        _personImage = personImage;
      }
      if (recognizedText?.isNotEmpty ?? false) {
        PassportModel? passportData =
            _parsePassportExtractedText(recognizedText!, personImage);

        setState(() {
          _nameController.text = passportData.name ?? '';
          _travelDocumentNumberController.text =
              passportData.passportNumber ?? '';
          DateFormat format = DateFormat('dd/MM/yyyy');
          _selectedTravelDocumentIssueDate =
              format.tryParse(passportData.issueDate ?? '');
          _selectedTravelDocumentExpiryDate =
              format.tryParse(passportData.expiryDate ?? '');
          List<Country>? countries =
              context.read<GuestCheckInCubit>().state.countries;
          if ((passportData.nationality?.isNotEmpty ?? false) &&
              (countries?.isNotEmpty ?? false)) {
            final normalized = passportData.nationality?.trim().toLowerCase();

            final Country? matchedCountry = countries?.firstWhere(
              (item) => item.name?.toLowerCase() == normalized,
              orElse: () => Country(),
            );

            if (matchedCountry?.id != null) {
              context
                  .read<GuestCheckInCubit>()
                  .onChangeSelectedNationality(matchedCountry);
            }
          }
        });
      }
    }
  }

  Future<OcrModel?> _scanDocumentAndPerformOCR() async {
    DocumentScannerOptions documentOptions = DocumentScannerOptions(
      documentFormat: DocumentFormat.jpeg, // set output document format
      mode: ScannerMode.base, // to control what features are enabled
      pageLimit: 1, // setting a limit to the number of pages scanned
      isGalleryImport: false, // importing from the photo gallery
    );
    final documentScanner = DocumentScanner(options: documentOptions);
    DocumentScanningResult result = await documentScanner.scanDocument();
    File? scannedImageFile;
    final List<String> images = result.images;
    if (images.isNotEmpty && images.first.isNotEmpty) {
      scannedImageFile = File(images.first);

      return await _performOCR(scannedImageFile);
    }
    return null;
  }

  Future<OcrModel> _performOCR(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    TextRecognizer textDetector =
        TextRecognizer(script: TextRecognitionScript.latin);
    FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        minFaceSize: 1,
      ),
    );

    final RecognizedText recognizedText =
        await textDetector.processImage(inputImage);
    String text = recognizedText.text;

    final List<Face> faces = await faceDetector.processImage(inputImage);

    final File? extractedPersonImage = _extractPersonImage(imageFile, faces);
    textDetector.close();
    faceDetector.close();
    return OcrModel(personImage: extractedPersonImage, recognizedTExt: text);
  }

  File? _extractPersonImage(File originalImage, List<Face> faces) {
    if (faces.isNotEmpty) {
      File? image;
      for (int i = 0; i < faces.length; i++) {
        final face = faces[i];
        final boundingBox = face.boundingBox;
        image = _cropImage(originalImage, boundingBox, index: i);
      }
      return image;
    }
    return null; // Return null if no image is extracted
  }

  File? _cropImage(
    File originalImage,
    Rect boundingBox, {
    required int index,
  }) {
    // Load the original image
    final img.Image originalImg =
        img.decodeImage(originalImage.readAsBytesSync())!;

    // Calculate the cropping dimensions
    final int left = boundingBox.left.toInt() - 130;
    final int top = boundingBox.top.toInt() - 130;
    final int width = ((boundingBox.right - boundingBox.left).toInt()) + 270;
    final int height = ((boundingBox.bottom - boundingBox.top).toInt()) + 270;
    // Crop the image
    final img.Image croppedImg = img.copyCrop(originalImg,
        x: left, y: top, width: width, height: height);

    // Save the cropped image to a new file
    final String fileName =
        '${path.basenameWithoutExtension(originalImage.path)}_cropped_$index.jpg';
    final String dir = path.dirname(originalImage.path);
    final File croppedFile = File('$dir/$fileName')
      ..writeAsBytesSync(img.encodeJpg(croppedImg));

    return croppedFile; // Return the cropped image file
  }

  Map<String, String> _parseEmiratesIdExtractedText(String text) {
    Map<String, String> parsedData = {};
    List<String> lines = text.split('\n');

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      String lineLower = line.toLowerCase();

      // ID Number
      if (lineLower.contains('رقم الهوية') || lineLower.contains('id number')) {
        parsedData['ID Number'] = _extractValue(line, lines, i);
      }
      // Name (special case)
      else if (lineLower.contains('الاسم') || lineLower.contains('name')) {
        if (line.contains(':')) {
          parsedData['Name'] = line.split(':').last.trim();
        }
      }
      // Nationality
      else if (lineLower.contains('الجنسية') ||
          lineLower.contains('nationality')) {
        parsedData['Nationality'] = _extractValue(line, lines, i);
      }
      // Issuing Date (ONLY next line)
      else if (lineLower.contains('تاريخ الاصدار/') ||
          lineLower.contains('issuing date')) {
        if (i + 1 < lines.length) {
          parsedData['Issuing Date'] = lines[i + 1].trim();
        }
      }
      // Expiry Date (ONLY next line)
      else if (lineLower.contains('تاريخ الانتهاء/') ||
          lineLower.contains('expiry date')) {
        if (i + 1 < lines.length) {
          parsedData['Expiry Date'] = lines[i + 1].trim();
        }
      }
    }
    return parsedData;
  }

  DrivingLicenseModel _parseDrivingLicenseExtractedText(
      String rawText, File? imageFile) {
    log('DrivingLicense rawText::$rawText');
// Split into lines
    //final lines = rawText.split('\n').map((line) => line.trim()).toList();
    final lines = rawText
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    String? licenseNumber;
    String? name;
    String? nationality;
    String? dateOfBirth;
    String? issueDate;
    String? expiryDate;

    // final dateRegex = RegExp(r'\d{2}/\d{2}/\d{4}');
    final dateRegex = RegExp(r'(\d{2}/\d{2}/\d{4})|' // 12/05/2023
        r'(\d{2}-\d{2}-\d{4})|' // 19-01-1993
        r'(\d{4}-\d{2}-\d{2})|' // 2023-05-12
        r'([A-Za-z]+ \d{1,2}, \d{4})|' // May 12, 2023
        r'(\d{1,2} [A-Za-z]+ \d{4})|' // 12 May 2023
        r'(\d{2}\.\d{2}\.\d{4})' // 12.05.2023
        );

    String? normalizeDate(String input) {
      final formats = [
        DateFormat('dd/MM/yyyy'),
        DateFormat('yyyy-MM-dd'),
        DateFormat('dd-MM-yyyy'),
        DateFormat('MMMM d, yyyy'),
        DateFormat('dd MMM yyyy'),
        DateFormat('dd.MM.yyyy'),
        DateFormat('d MMMM yyyy'),
      ];

      for (final format in formats) {
        try {
          final date = format.parseStrict(input);
          return DateFormat('yyyy-MM-dd').format(date);
        } catch (_) {}
      }

      return null;
    }

    final licenseRegex = RegExp(r'^\d{6,}$'); // Numeric and >= 6 digits

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      // Debug: Print current line being processed
      print('Processing line $i: "$line"');
      // License number
      if (licenseNumber == null && licenseRegex.hasMatch(line)) {
        licenseNumber = licenseRegex.firstMatch(line)!.group(0);
      }

      // Name
      if (name == null && line.toLowerCase().contains('name')) {
        name =
            line.replaceFirst(RegExp(r'name', caseSensitive: false), '').trim();
        if (name.isEmpty && i + 1 < lines.length) {
          name = lines[i + 1].trim();
        }
      }

      // Nationality
      // if (nationality == null && line.toLowerCase().contains('nationality')) {
      //   nationality = line
      //       .replaceFirst(RegExp(r'nationality', caseSensitive: false), '')
      //       .trim();
      //   if (nationality.isEmpty && i + 1 < lines.length) {
      //     print('nationality$nationality');
      //     nationality = lines[i + 1].trim();
      //   }
      // }
      /////

      if (nationality == null && line.toLowerCase().contains('nationality')) {
        // Look ahead for up to 5 lines to find a likely nationality value
        for (int j = 1; j <= 5 && i + j < lines.length; j++) {
          final nextLine = lines[i + j].trim();
          // Filter: must be a country-like value (uppercase alphabets, shortish)
          if (nextLine.isNotEmpty &&
              nextLine.length <= 30 &&
              RegExp(r'^[A-Z ]+$').hasMatch(nextLine)) {
            nationality = nextLine;
            break;
          }
        }

        print('Extracted Nationality: "$nationality"');
      }

      final matches = dateRegex.allMatches(line);
      for (final match in matches) {
        final rawDate = match.group(0);
        if (rawDate != null) {
          final normalized = normalizeDate(rawDate);
          if (normalized != null) {
            if (dateOfBirth == null) {
              dateOfBirth = normalized;
            } else if (issueDate == null) {
              issueDate = normalized;
            } else if (expiryDate == null) {
              expiryDate = normalized;
            }
          }
        }
      }

      // final matches = dateRegex.allMatches(line);
      // for (final match in matches) {
      //   final rawDate = match.group(0);
      //   if (rawDate != null) {
      //     final normalized = normalizeDate(rawDate);
      //     if (normalized != null) {
      //       if (dateOfBirth == null) {
      //         dateOfBirth = normalized;
      //       } else if (issueDate == null) {
      //         issueDate = normalized;
      //       } else if (expiryDate == null) {
      //         expiryDate = normalized;
      //       }
      //     }
      //   }
      // }
    }

    return DrivingLicenseModel(
      personImage: imageFile,
      name: name,
      licenseNumber: licenseNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      nationality: nationality,
    );
  }

  PassportModel _parsePassportExtractedText(String rawText, File? imageFile) {
    final lines = rawText.split('\n').map((line) => line.trim()).toList();
    print('Passport rawText$rawText');

    String? name;
    String? passportNumber;
    String? issueDate;
    String? expiryDate;
    String? nationality;

    final allDateRegex = RegExp(
      r'\b(?:\d{1,2}[\/\-. ])(?:\d{1,2}|[A-Za-z]{3,})[\/\-. ]\d{2,4}\b|'
      r'\b\d{4}[\/\-. ]\d{1,2}[\/\-. ]\d{1,2}\b|'
      r'\b\d{1,2} [A-Za-z]{3,9} \d{4}\b',
      caseSensitive: false,
    );
    final passportNoRegex = RegExp(r'^[A-Z0-9]{6,}$'); // Passport No format

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      // Passport Number
      if (passportNumber == null &&
          line.toLowerCase().contains('passport no')) {
        if (i + 1 < lines.length && passportNoRegex.hasMatch(lines[i + 1])) {
          passportNumber = lines[i + 1];
        }
      }

      // Name (line before "Date of Birth")
      if (name == null &&
          line.toLowerCase().contains('date of birth') &&
          i > 0) {
        name = lines[i - 1].trim();
      }

      // Nationality
      if (nationality == null && line.toLowerCase().contains('nationality')) {
        // Check same line first
        final parts = line.split(RegExp(r'nationality', caseSensitive: false));
        if (parts.length > 1 && parts[1].trim().isNotEmpty) {
          nationality = parts[1].trim();
        } else if (i + 1 < lines.length) {
          final nextLine = lines[i + 1].trim();
          // Ensure it's not an unrelated keyword like "Country Code" or name
          if (!nextLine.toLowerCase().contains('country') &&
              !nextLine.toLowerCase().contains('code') &&
              !nextLine.toLowerCase().contains('name') &&
              !allDateRegex.hasMatch(nextLine)) {
            nationality = nextLine;
          }
        }
      }

      // Dates
      final matches =
          allDateRegex.allMatches(line).map((m) => m.group(0)!.trim()).toList();
      for (final rawDate in matches) {
        final parsed = DateTimeUtil.tryParseDate(rawDate);
        if (parsed != null) {
          final formatted = DateFormat('dd/MM/yyyy').format(parsed);
          if (issueDate == null) {
            issueDate = formatted;
          } else {
            expiryDate ??= formatted;
          }
        }
      }
    }

    return PassportModel(
      personImage: imageFile,
      name: name,
      passportNumber: passportNumber,
      issueDate: issueDate,
      expiryDate: expiryDate,
      nationality: nationality,
    );
  }

  String _extractValue(String line, List<String> lines, int currentIndex) {
    if (line.contains(':')) {
      return line.split(':').last.trim();
    } else if (currentIndex + 1 < lines.length) {
      return lines[currentIndex + 1].trim();
    }
    return '';
  }
}

class TypeItemModel {
  final String value;
  final String label;

  TypeItemModel({required this.value, required this.label});
}
