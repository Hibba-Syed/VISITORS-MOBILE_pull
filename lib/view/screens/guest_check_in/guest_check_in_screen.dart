import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/container_widgets/type_container_widget.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';
import 'package:visitors/view/widgets/picker/custom_date_time_picker.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../model/check_ins/countries_model.dart';
import 'components/select_visitor_number_widget.dart';
import '../../widgets/button/custom_button.dart';

class GuestCheckInScreen extends StatefulWidget {
  const GuestCheckInScreen({super.key});

  @override
  State<GuestCheckInScreen> createState() => _GuestCheckInScreenState();
}

class _GuestCheckInScreenState extends State<GuestCheckInScreen> {
  final TextEditingController _visitorCountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passportExpiryController =
      TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  String? _selectedItemType;
  String? _selectedItemPurpose;
  String? _selectedItemUnit;
  String? _selectedItemNationality;
  String? _selectedIssueDate;
  String? _selectedExpiryDate;
  Countries? countries;
  File? _imageFile;
  List<File?>? _personImageFiles;
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

  String _extractValue(String line, List<String> lines, int currentIndex) {
    if (line.contains(':')) {
      return line.split(':').last.trim();
    } else if (currentIndex + 1 < lines.length) {
      return lines[currentIndex + 1].trim();
    }
    return '';
  }

  List<File?>? _extractPersonImage(File originalImage, List<Face> faces) {
    if (faces.isNotEmpty) {
      print('bounding box length:: ${faces.length}');

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
    final int left = boundingBox.left.toInt();
    final int top = boundingBox.top.toInt();
    final int width = (boundingBox.right - boundingBox.left).toInt();
    final int height = (boundingBox.bottom - boundingBox.top).toInt();

    print('left:: $left');
    print('top:: $top');
    print('width:: $width');
    print('height:: $height');
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

  Future<void> _performOCR(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    TextRecognizer textDetector =
        TextRecognizer(script: TextRecognitionScript.latin);
    FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(),
    );

    final RecognizedText recognizedText =
        await textDetector.processImage(inputImage);
    String text = recognizedText.text;

    final List<Face> faces = await faceDetector.processImage(inputImage);

    ///
    final parsedData = _parseExtractedText(text);

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

      // if (nationality != null && _nationalityItems.isNotEmpty) {
      //   final normalized = nationality.trim().toLowerCase();
      //
      //   final match = _nationalityItems.firstWhere(
      //     (item) => item.toLowerCase() == normalized,
      //     orElse: () => '',
      //   );
      //
      //   if (match.isNotEmpty) {
      //     setState(() {
      //       _selectedItemNationality = match;
      //     });
      //   }
      // }
    });
    textDetector.close();
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

    print(
        'Parsed UAE ID Data: ${parsedData['Expiry Date']}${parsedData['Issuing Date']}${parsedData['Nationality']}');
    return parsedData;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          child: CustomButton(
              imageHeight: AppUtils.isTablet(context) ? 22 : 18,
              image: AppImages.checkInButton,
              buttonColor: AppColors.green,
              text: 'Check-In',
              onPressed: () {
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
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                  const Text(
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
                                    "Nationality",
                                    style: AppTextStyles.style12Black600,
                                  ),
                                  const Gap(8),
                                  SingleSelectedDropdownWidget<Countries>(
                                    outLineColor: AppColors.gray,
                                    hint: "Select Nationality",
                                    fillColor: AppColors.white,
                                    selectedItem: context
                                        .read<GuestCheckInCubit>()
                                        .state
                                        .selectedCountries,
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
                                          insetPadding:
                                              AppUtils.isTablet(context)
                                                  ? EdgeInsets.symmetric(
                                                      horizontal: 35)
                                                  : EdgeInsets.symmetric(
                                                      horizontal: 10),
                                          title: 'Select Visitor',
                                          contentBuilder: (context, setState) {
                                            return SelectVisitorNumberWidget(
                                              count: 3,
                                              name:
                                                  'Muhammad Ahmad Bin Ali Al Shehzad ur Rahman',
                                              country: 'Pakistan',
                                              profileImageUrl:
                                                  'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                            );
                                          });
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 68,
                        height: 68,
                        color: AppColors.darkGrey.withAlpha(25),
                        child: Column(
                          children: _personImageFiles?.map((element) {
                                return Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.file(element!),
                                );
                              }).toList() ??
                              [],
                        ),
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
                                          TypeContainerWidget(
                                            text: 'Passport',
                                            onTap: () {
                                              _pickImage();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TypeContainerWidget(
                                            text: 'Emirates Id',
                                            onTap: () {
                                              _pickImage();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TypeContainerWidget(
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
                          style: AppTextStyles.style13Black600,
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
                        // SingleSelectedDropdownWidget<UnitModel>(
                        //     hint: "Unit",
                        //     fillColor: AppColors.white,
                        //     selectedItem:
                        //     context.watch<CheckInsCubit>().state.selectedUnit,
                        //     itemAsString: (unit) => unit.unitNumber ?? "",
                        //     compareFn: (unit, item) => unit.id == item.id,
                        //     items: state.units ?? [],
                        //     onChanged: (value) {
                        //       context
                        //           .read<CheckInsCubit>()
                        //           .onChangeSelectedUnit(value!);
                        //     });
                        SingleSelectedDropdownWidget<Countries>(
                          outLineColor: AppColors.gray,
                          hint: "Select Nationality",
                          fillColor: AppColors.white,
                          selectedItem: context
                              .read<GuestCheckInCubit>()
                              .state
                              .selectedCountries,
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
                        const Gap(5),
                        const Text(
                          "Type*",
                          style: AppTextStyles.style12Black600,
                        ),
                        const Gap(5),
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
                        const Gap(5),
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
                        const Gap(5),
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
                                    WidgetStateProperty.all(Colors.transparent),
                              ),
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialogBox(
                                        hideBothButtons: true,
                                        insetPadding: AppUtils.isTablet(context)
                                            ? EdgeInsets.symmetric(
                                                horizontal: 30)
                                            : EdgeInsets.symmetric(
                                                horizontal: 10),
                                        title: 'Select Visitor',
                                        contentBuilder: (context, setState) {
                                          return const SelectVisitorNumberWidget(
                                            count: 3,
                                            name:
                                                'Muhammad Ahmad Bin Ali Al Shehzad ur Rahman',
                                            country: 'Pakistan',
                                            profileImageUrl:
                                                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
