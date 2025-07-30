import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/bloc/guest_check_in/guest_check_in_cubit.dart';
import 'package:visitors/model/driving_license_model.dart';
import 'package:visitors/model/emirates_id_model.dart';
import 'package:visitors/model/passport_model.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/service/scaner/scanner_service.dart';
import 'package:visitors/view/screens/guest_check_in/components/get_info_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/picker/custom_date_picker.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';
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

  void _onScanPassportTap(BuildContext context) async {
    // PassportModel? passportData =
    //     await ScannerService().scanPassportAndPerformOcr();
    PassportModel? passportData =
        await ScannerService().scanMrzForPassportAndParse(context);
    if (passportData != null) {
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
    }
  }

  void _onScanEmiratesIdTap() async {
    EmiratesIdModel? emiratesIdData =
        await ScannerService().scanEmiratesIdAndPerformOcr();
    if (emiratesIdData != null) {
      clearData();

      setState(() {
        _personImage = emiratesIdData.personImage;
        _nameController.text = emiratesIdData.name ?? '';
        _emiratesIdNumberController.text = emiratesIdData.idNumber ?? '';
        DateFormat format = DateFormat('dd/MM/yyyy');
        _selectedEmiratesIdIssueDate =
            format.tryParse(emiratesIdData.issueDate ?? '');
        _selectedEmiratesIdExpiryDate =
            format.tryParse(emiratesIdData.expiryDate ?? '');
        List<Country>? countries =
            context.read<GuestCheckInCubit>().state.countries;
        if ((emiratesIdData.nationality?.isNotEmpty ?? false) &&
            (countries?.isNotEmpty ?? false)) {
          final normalized = emiratesIdData.nationality?.trim().toLowerCase();

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

  Future<void> _onScanDrivingLicenseTap() async {
    DrivingLicenseModel? drivingLicenseData =
        await ScannerService().scanDrivingLicenseAndPerformOcr();
    if (drivingLicenseData != null) {
      clearData();
      setState(() {
        _personImage = drivingLicenseData.personImage;
        _nameController.text = drivingLicenseData.name ?? '';
        _photoIdNumberController.text = drivingLicenseData.licenseNumber ?? '';
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

class TypeItemModel {
  final String value;
  final String label;

  TypeItemModel({required this.value, required this.label});
}
