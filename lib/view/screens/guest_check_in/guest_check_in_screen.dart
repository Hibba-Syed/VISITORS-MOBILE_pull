import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:visitors/bloc/guest_check_in/guest_check_in_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/screens/guest_check_in/components/get_info_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/container_widgets/scan_type_container_widget.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';
import 'package:visitors/view/widgets/picker/custom_date_time_picker.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../bloc/check_ins/check_ins_cubit.dart';
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
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passportExpiryController =
      TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  String? _selectedItemType;
  String? _selectedIssueDate;
  String? _selectedExpiryDate;
  String? _selectedItemNationality;
  File? _imageFile;
  List<File?>? _personImageFiles;
  final List<String> _nationalityItems = [
    'Pakistan',
    'Australia',
    'United Arab Emirates',
    'India'
  ];
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 539, maxHeight: 340);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      await _performOCR(_imageFile!);
    }
  }

  Future<void> _performOCR(File imageFile) async {
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

    ///
    final Map<String, String> parsedData = _parseExtractedText(text);

    setState(() {
      // _extractedText = text;
      _personImageFiles = _extractPersonImage(imageFile, faces);

      // Auto-fill form fields
      _nameController.text = parsedData['Name'] ?? '';
      _selectedItemNationality = parsedData['Nationality'];
      _idNumberController.text = parsedData['ID Number'] ?? '';
      _selectedIssueDate = parsedData['Issuing Date'] ?? '';
      _selectedExpiryDate = parsedData['Expiry Date'] ?? '';
      _passportExpiryController.text = parsedData[''] ?? '';
      _passportNumberController.text = parsedData[''] ?? '';

      String? nationality =
          parsedData['Nationality'] ?? parsedData['nationality'];

      if (nationality != null && _nationalityItems.isNotEmpty) {
        final normalized = nationality.trim().toLowerCase();

        final match = _nationalityItems.firstWhere(
          (item) => item.toLowerCase() == normalized,
          orElse: () => '',
        );

        if (match.isNotEmpty) {
          setState(() {
            _selectedItemNationality = match;
          });
        }
      }
    });
    textDetector.close();
  }

  List<File?>? _extractPersonImage(File originalImage, List<Face> faces) {
    if (faces.isNotEmpty) {

      List<File?>? images = [];
      for (int i = 0; i < faces.length; i++) {
        final face = faces[i];
        final boundingBox = face.boundingBox;
        images.add(_cropImage(originalImage, boundingBox, index: i));
      }
      for (var element in images) {
        print(element?.path);
      }
      return images;
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
    final int left = boundingBox.left.toInt() - 20;
    final int top = boundingBox.top.toInt() - 16;
    final int width = ((boundingBox.right - boundingBox.left).toInt()) + 40;
    final int height = ((boundingBox.bottom - boundingBox.top).toInt()) + 46;

    // print('left:: $left');
    // print('top:: $top');
    // print('width:: $width');
    // print('height:: $height');
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

  Map<String, String> _parseExtractedText(String text) {
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
      // // Issuing Date
      // else if (lineLower.contains('تاريخ الاصدار') || lineLower.contains('issuing date')) {
      //   parsedData['Issuing Date'] = _extractValue(line, lines, i);
      // }
      // // Expiry Date
      // else if (lineLower.contains('تاريخ الانتهاء') || lineLower.contains('expiry date')) {
      //   parsedData['Expiry Date'] = _extractValue(line, lines, i);
      // }
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

    // print(
    //     'Parsed UAE ID Data: ${parsedData['Expiry Date']}${parsedData['Issuing Date']}${parsedData['Nationality']}');
    return parsedData;
  }

  String _extractValue(String line, List<String> lines, int currentIndex) {
    if (line.contains(':')) {
      return line.split(':').last.trim();
    } else if (currentIndex + 1 < lines.length) {
      return lines[currentIndex + 1].trim();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Guest Check-In',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: width >= AppConstants.tabletScreen
            ? tabletGuestCheckInScreen(context)
            : mobileGuestCheckInScreen(context),
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
                  text: 'Check-In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<GuestCheckInCubit>()
                          .guestCheckIn(context, data: {
                        'type': _selectedItemType,
                        'name': _nameController.text,
                        'purpose': state.selectedPurpose,
                        'unit_id': state.selectedUnit?.id,
                        'unit_number': state.selectedUnit,
                        'visitor_count': _visitorCountController.text,
                        'phone': _phoneNumberController.text,
                        'email': _emailController.text,
                        'entry_card_number': _entryCardNumberController.text,
                        'nationality': state.selectedCountry,
                        'description': _descriptionController.text,
                        'serviceable_id': '',
                        'serviceable_type': '',
                        'sms': false,
                        'visitor_id': ''
                      });

                      if (_phoneNumberKey.currentState!.validate()) {
                        // print("Form is valid. Proceeding with check-in...");
                      } else {
                        // print("Form validation failed.");
                      }
                    }
                  });
            },
          ),
        ),
      ),
    );
  }

  Widget tabletGuestCheckInScreen(BuildContext context) {
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
                  const Gap(20),
                  Align(
                    alignment: Alignment.center,
                    child: const NetworkImageWidget(
                      url:
                          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
                                  insetPadding: AppUtils.isTablet(context)
                                      ? EdgeInsets.all(70)
                                      : EdgeInsets.all(10),
                                  hideBothButtons: true,
                                  title: 'Select Type',
                                  contentBuilder: (context, setState) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Select any ID type for Scan',
                                            style: AppUtils.isTablet(context)
                                                ? AppTextStyles.style16black600
                                                : AppTextStyles
                                                    .style14Black600),
                                        Gap(20),
                                        AppUtils.isTablet(context)
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ScanTypeContainerWidget(
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
                                                    ScanTypeContainerWidget(
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
                                                    ScanTypeContainerWidget(
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
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ScanTypeContainerWidget(
                                                    text: 'Passport',
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ScanTypeContainerWidget(
                                                    text: 'Emirates Id',
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ScanTypeContainerWidget(
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
                                outLineColor: AppColors.outLineGray,
                                enabledBorder: InputBorder.none,
                                controller: _idNumberController,
                                label: 'ID Number',
                                hint: 'Enter id number',
                                keyboardType: TextInputType.text,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'required';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: TextFieldWidget(
                                enabledBorder: InputBorder.none,
                                controller: _nameController,
                                label: 'Name*',
                                hint: 'Enter name',
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
                                    hintText: 'Date of issue',
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
                                    // outLineColor: AppColors.outLineGray
                                    fillColor: AppColors.white,
                                    hintText: 'Date of issue',
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
                                outLineColor: AppColors.outLineGray,
                                enabledBorder: InputBorder.none,
                                controller: _passportNumberController,
                                label: 'Passport Number',
                                hint: 'Passport number',
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextFieldWidget(
                                outLineColor: AppColors.outLineGray,
                                fillColor: AppColors.white,
                                enabledBorder: InputBorder.none,
                                controller: _passportExpiryController,
                                label: 'Passport Expiry',
                                hint: 'Passport expiry',
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
                                    hint: "Select type",
                                    fillColor: AppColors.white,
                                    selectedItem: _selectedItemType,
                                    compareFn: (p0, p1) => p0 == p1,
                                    items: const [
                                      'Unit Visit',
                                      'Community Visit',
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedItemType = value;
                                      });
                                    },
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
                            const Gap(10),
                            Expanded(
                              child: TextFieldWidget(
                                controller: _visitorCountController,
                                label: 'Visitor Count*',
                                hint: 'Enter count ',
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
                        if (_selectedItemType == 'Unit Visit')
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Purpose*",
                                      style: AppTextStyles.style12Black600,
                                    ),
                                    const Gap(8),
                                    SingleSelectedDropdownWidget<
                                        VisitorsPurpose>(
                                      hint: "Select purpose",
                                      fillColor: AppColors.white,
                                      selectedItem: context
                                          .watch<GuestCheckInCubit>()
                                          .state
                                          .selectedPurpose,
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
                                      // validator: (value) {
                                      //   if (value?.purpose?.isNotEmpty ?? false) {
                                      //     return 'required';
                                      //   }
                                      //   return null;
                                      // },
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
                                    SingleSelectedDropdownWidget<UnitModel>(
                                      hint: "Unit",
                                      fillColor: AppColors.white,
                                      selectedItem: context
                                          .watch<GuestCheckInCubit>()
                                          .state
                                          .selectedUnit,
                                      itemAsString: (unit) =>
                                          unit.unitNumber ?? "",
                                      compareFn: (unit, item) =>
                                          unit.id == item.id,
                                      items: state.units ?? [],
                                      onChanged: (value) {
                                        context
                                            .read<GuestCheckInCubit>()
                                            .onChangeSelectedUnit(value!);
                                      },
                                      validator: (value) {
                                        if (value?.name?.isNotEmpty ?? false) {
                                          return 'required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Nationality",
                                    style: AppTextStyles.style12Black600,
                                  ),
                                  const Gap(8),
                                  SingleSelectedDropdownWidget<Country>(
                                    outLineColor: AppColors.outLineGray,
                                    hint: "Select nationality",
                                    fillColor: AppColors.white,
                                    selectedItem: context
                                        .watch<GuestCheckInCubit>()
                                        .state
                                        .selectedCountry,
                                    items: state.countries ?? [],
                                    itemAsString: (country) =>
                                        country.name ?? "",
                                    compareFn: (p0, p1) => p0.id == p1.id,
                                    onChanged: (value) {
                                      context
                                          .read<GuestCheckInCubit>()
                                          .onChangeSelectedCountry(value);
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
                                hint: 'Enter email',
                              ),
                            ),
                          ],
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          controller: _entryCardNumberController,
                          label: 'Entry Card Number',
                          hint: 'Enter card number',
                        ),
                        const Gap(5),
                        Form(
                          key: _phoneNumberKey,
                          child: TextFieldWidget(
                            label: "Phone Number*",
                            hint: "Enter phone number",
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
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                ),
                                onPressed: () async {
                                  final phoneNumber =
                                      _phoneNumberController.text.trim();

                                  if (phoneNumber.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please type note first.");
                                    return;
                                  }
                                  if (!(_phoneNumberKey.currentState
                                          ?.validate() ??
                                      false)) {
                                    return;
                                  }
                                  await context
                                      .read<GuestCheckInCubit>()
                                      .getNumberInfo(phoneNumber: phoneNumber);
                                  if (!context.mounted) return;
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialogBox(
                                        hideBothButtons: true,
                                        insetPadding: AppUtils.isTablet(context)
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 35)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        title: 'Select Visitor',
                                        contentBuilder: (context, setState) {
                                          return visitorNumberWidget(
                                            _phoneNumberController.text,
                                            remainingVisitors: ((context
                                                        .read<
                                                            GuestCheckInCubit>()
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
                                },
                                child: const Text("Get Info",
                                    style: TextStyle(color: AppColors.primary)),
                              ),
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget mobileGuestCheckInScreen(BuildContext context) {
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
                      child:
                          (_personImageFiles?.first?.path.isNotEmpty ?? false)
                              ? Image.file(
                                  _personImageFiles!.first!,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ScanTypeContainerWidget(
                                            text: 'Passport',
                                            onTap: () {
                                              _pickImage();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ScanTypeContainerWidget(
                                            text: 'Emirates Id',
                                            onTap: () {
                                              _pickImage();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ScanTypeContainerWidget(
                                            text: 'Driving license',
                                            onTap: () {
                                              _pickImage();
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
                          outLineColor: AppColors.outLineGray,
                          enabledBorder: InputBorder.none,
                          controller: _nameController,
                          label: 'Name*',
                          hint: 'Enter name',
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
                          outLineColor: AppColors.outLineGray,
                          enabledBorder: InputBorder.none,
                          controller: _idNumberController,
                          label: 'ID Number',
                          hint: 'Enter id number',
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
                          style: AppTextStyles.style13Black600,
                        ),
                        const Gap(8),
                        CustomDateTimePickerWidget(
                          fillColor: AppColors.white,
                          hintText: 'Date of issue',
                          onlyDatePicker: true,
                          selectedDateTime: _selectedIssueDate,
                          onChangeDateTime: (value) {
                            _selectedIssueDate = value;
                            //print('Selected Date: $value');
                          },
                        ),
                        const Gap(5),
                        const Text(
                          "Date of expiry",
                          style: AppTextStyles.style13Black600,
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
                          style: AppTextStyles.style13Black600,
                        ),
                        const Gap(5),
                        SingleSelectedDropdownWidget<Country>(
                          outLineColor: AppColors.outLineGray,
                          hint: "United Arab Emirates",
                          fillColor: AppColors.white,
                          selectedItem: context
                              .watch<GuestCheckInCubit>()
                              .state
                              .selectedCountry,
                          items: state.countries ?? [],
                          itemAsString: (country) => country.name ?? "",
                          compareFn: (p0, p1) => p0.id == p1.id,
                          onChanged: (value) {
                            context
                                .read<GuestCheckInCubit>()
                                .onChangeSelectedCountry(value);
                          },
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.outLineGray,
                          enabledBorder: InputBorder.none,
                          controller: _passportNumberController,
                          label: 'Passport Number',
                          hint: 'Passport number',
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
                          outLineColor: AppColors.outLineGray,
                          enabledBorder: InputBorder.none,
                          controller: _passportExpiryController,
                          label: 'Passport Expiry',
                          hint: 'Passport expiry',
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
                          "Type*",
                          style: AppTextStyles.style12Black600,
                        ),
                        const Gap(5),
                        SingleSelectedDropdownWidget<String>(
                          outLineColor: AppColors.outLineGray,
                          hint: "Select type",
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
                          outLineColor: AppColors.outLineGray,
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
                        if (_selectedItemType == 'Unit Visit') ...[
                          const Text(
                            "Purpose*",
                            style: AppTextStyles.style12Black600,
                          ),
                          const Gap(5),
                          SingleSelectedDropdownWidget<VisitorsPurpose>(
                            hint: "Select purpose",
                            fillColor: AppColors.white,
                            outLineColor: AppColors.outLineGray,
                            selectedItem: context
                                .watch<GuestCheckInCubit>()
                                .state
                                .selectedPurpose,
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
                              if (value?.purpose?.isNotEmpty ?? false) {
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
                          const Gap(5),
                          SingleSelectedDropdownWidget<UnitModel>(
                            outLineColor: AppColors.outLineGray,
                            hint: "Unit",
                            fillColor: AppColors.white,
                            selectedItem: context
                                .watch<CheckInsCubit>()
                                .state
                                .selectedUnit,
                            itemAsString: (unit) => unit.unitNumber ?? "",
                            compareFn: (unit, item) => unit.id == item.id,
                            items: state.units ?? [],
                            onChanged: (value) {
                              context
                                  .read<CheckInsCubit>()
                                  .onChangeSelectedUnit(value!);
                            },
                            validator: (value) {
                              if (value?.name?.isNotEmpty ?? false) {
                                return 'required';
                              }
                              return null;
                            },
                          ),
                        ],
                        const Gap(5),
                        Form(
                          key: _phoneNumberKey,
                          child: TextFieldWidget(
                            outLineColor: AppColors.gray,
                            label: "Phone number*",
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
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  final phoneNumber =
                                      _phoneNumberController.text.trim();

                                  if (phoneNumber.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please type note first.");
                                    return;
                                  }

                                  if (!_phoneNumberKey.currentState!
                                      .validate()) {
                                    return;
                                  }

                                  context
                                      .read<GuestCheckInCubit>()
                                      .getNumberInfo(phoneNumber: phoneNumber);

                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialogBox(
                                        hideBothButtons: true,
                                        insetPadding: AppUtils.isTablet(context)
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 35)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        title: 'Select Visitor',
                                        contentBuilder: (context, setState) {
                                          return visitorNumberWidget(
                                              _phoneNumberController.text);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Text("Get Info",
                                    style: TextStyle(color: AppColors.primary)),
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.gray,
                          controller: _emailController,
                          label: 'Email',
                          hint: 'Enter email',
                        ),
                        const Gap(5),
                        TextFieldWidget(
                          outLineColor: AppColors.gray,
                          controller: _entryCardNumberController,
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget visitorNumberWidget(String phoneNumber, {int? remainingVisitors}) {
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
              'No visitor records found for this number',
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
              'Visitor records found for this number',
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
                    country: numberInfo?.nationality ?? '',
                    profileImageUrl: numberInfo?.imageUrl ?? '',
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
}
