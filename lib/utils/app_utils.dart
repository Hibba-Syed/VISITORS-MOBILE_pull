import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:visitors/view/screens/services/detail/custom_service_details_screen.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import '../bloc/e_service/details/service_details_cubit.dart';
import '../model/driving_license_model.dart';
import '../model/emirates_id_model.dart';
import '../model/passport_model.dart';
import '../model/service/service_model.dart';
import '../resource/constants/images.dart';
import '../resource/constants/strings.dart';
import '../resource/styles/styles.dart';
import '../service/scanner/scanner_service.dart';
import '../view/screens/guest_check_in/guest_check_in_screen.dart';
import '../view/screens/services/detail/access_device_service_details_sceen.dart';
import '../view/screens/services/detail/delivery_permit_service_details_screen.dart';
import '../view/screens/services/detail/facility_booking_service_details_screen.dart';
import '../view/screens/services/detail/fit_out_service_details_screen.dart';
import '../view/screens/services/detail/move_in_service_details_screen.dart';
import '../view/screens/services/detail/move_out_service_details_screen.dart';
import '../view/screens/services/detail/short_stay_service_details_screen.dart';
import '../view/screens/services/detail/work_permit_service_details_screen.dart';
import '../view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import '../view/widgets/single_selected_dropdown_widget.dart';
import '../view/widgets/text field/text_field_widget.dart';

class AppUtils {
  // Status colors
  static Color getStatusColor(String? status) {
    if (status?.toLowerCase() == "active") {
      return AppColors.green;
    }
    if (status?.toLowerCase() == "approved") {
      return AppColors.green;
    }
    if (status?.toLowerCase() == "notified") {
      return AppColors.primary;
    }
    if (status?.toLowerCase() == "waiting for payment") {
      return Colors.grey;
    }

    return AppColors.red;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >=
        AppConstants.tabletScreen;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide <=
        AppConstants.mobileScreen;
  }

  static Color getCheckOutTypeColor(String? type) {
    if (type?.toLowerCase() == "community visit") {
      return AppColors.yellow;
    }
    if (type?.toLowerCase() == "community service") {
      return AppColors.primary;
    }
    if (type?.toLowerCase() == "unit visit") {
      return AppColors.cyanBlue;
    }
    if (type?.toLowerCase() == "guest") {
      return AppColors.green;
    }
    if (type?.toLowerCase() == "visitor_passes") {
      return AppColors.yellow;
    }
    if (type?.toLowerCase() == "service") {
      return AppColors.cyanBlue;
    }
    if (type?.toLowerCase() == "work order / rfp") {
      return AppColors.cyanBlue;
    }
    if (type?.toLowerCase() == "visitor pass") {
      return AppColors.yellow;
    }

    return AppColors.red;
  }

  // static String getDateRangeStringFromLabel(String label) {
  //   final now = DateTime.now();
  //   DateTime fromDate;
  //   if (label == 'Last 30 Days') {
  //     fromDate = now.subtract(const Duration(days: 30));
  //   } else if (label == 'Last 60 Days') {
  //     fromDate = now.subtract(const Duration(days: 60));
  //   } else if (label == 'Last 90 Days') {
  //     fromDate = now.subtract(const Duration(days: 90));
  //   } else {
  //     fromDate = now;
  //   }
  //   String format(DateTime date) {
  //     return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  //   }
  //
  //   return '${format(fromDate)} - ${format(now)}';
  // }
  //
  static DateTimeRange getDateRangeStringFromLabel(String? label) {
    final now = DateTime.now();
    DateTime fromDate;
    if (label == 'Last 30 Days') {
      fromDate = now.subtract(const Duration(days: 30));
    } else if (label == 'Last 60 Days') {
      fromDate = now.subtract(const Duration(days: 60));
    } else if (label == 'Last 90 Days') {
      fromDate = now.subtract(const Duration(days: 90));
    } else {
      fromDate = now;
    }
    return DateTimeRange(start: fromDate, end: now);
  }

  static TypeModel getServiceableType(String? type) {
    if (type == "job") {
      return TypeModel(label: "Work Order / RFP", value: Strings.keyWorkOrder);
    } else if (type == "application") {
      return TypeModel(label: "Service", value: Strings.keyServices);
    } else if (type == "App\\Models\\Visitor\\VisitorPass") {
      return TypeModel(label: "Visitor Pass", value: Strings.keyVisitorPass);
    } else if (type == "guest") {
      return TypeModel(label: "Guests", value: Strings.keyGuest);
    } else if (type == null || type.isEmpty) {
      return TypeModel(label: "Guest", value: Strings.keyGuest);
    } else {
      return TypeModel(label: "Select", value: "");
    }
  }

  static List<TypeModel> serviceTypeList = [
    TypeModel(label: AppUtils.languageTranslate('accessDevice'), value: 'AD'),
    TypeModel(label: AppUtils.languageTranslate('deliveryPermit'), value: 'DP'),
    TypeModel(
        label: AppUtils.languageTranslate('facilityBooking'), value: 'HB'),
    TypeModel(label: AppUtils.languageTranslate('fitOut'), value: 'FO'),
    TypeModel(label: AppUtils.languageTranslate('moveIn'), value: 'MI'),
    TypeModel(label: AppUtils.languageTranslate('moveOut'), value: 'MO'),
    TypeModel(label: AppUtils.languageTranslate('workPermit'), value: 'WP'),
    TypeModel(label: AppUtils.languageTranslate('shortStay'), value: 'SS'),
  ];

  static List<TypeModel> workOrderType = [
    TypeModel(label: AppUtils.languageTranslate('workOrder'), value: '1'),
    TypeModel(label: AppUtils.languageTranslate('rfp'), value: '0'),
  ];

  static List<TypeModel> checkInTypeList = [
    TypeModel(
        label: AppUtils.languageTranslate('guests'), value: Strings.keyGuest),
    TypeModel(
        label: AppUtils.languageTranslate('services'),
        value: Strings.keyServices),
    TypeModel(
        label: AppUtils.languageTranslate('workOrdersRFPs'),
        value: Strings.keyWorkOrder),
    TypeModel(
        label: AppUtils.languageTranslate('visitorPass'),
        value: Strings.keyVisitorPass),
  ];

  static Widget getServiceRouteName(ServiceModel? service) {
    String? type = service?.applicationTitle?.toLowerCase();

    switch (type) {
      case "ad":
        return AccessDeviceServiceDetailsScreen(service: service);
      case "hb":
        return FacilityBookingServiceDetailsScreen(service: service);
      case "dp":
        return DeliveryPermitServiceDetailsScreen(service: service);
      case "fo":
        return FitOutServiceDetailsScreen(service: service);
      case "mi":
        return MoveInServiceDetailsScreen(service: service);
      case "mo":
        return MoveOutServiceDetailsScreen(service: service);
      case "wp":
        return WorkPermitServiceDetailsScreen(service: service);
      case "ss":
        return ShortStayServiceDetailsScreen(service: service);
      case "ccs":
        return CustomServiceDetailsScreen(service: service);
      default:
        return Scaffold(
          appBar: AppBarWidget(
            title: AppUtils.languageTranslate('serviceDetails'),
            titleColor: AppColors.black,
            iconColor: AppColors.black,
          ),
          body: Center(
            child: Text(
              AppUtils.languageTranslate("no_service_details_available"),
              style: AppTextStyles.style13DarkGrey600,
            ),
          ),
        );
    }
  }

  static String? getRequestName(String? applicationType) {
    String? requestName;
    if (applicationType == "AD") {
      requestName = AppUtils.languageTranslate('accessDevice');
    }
    if (applicationType == "MI") {
      requestName = AppUtils.languageTranslate('moveIn');
    }
    if (applicationType == "MO") {
      requestName = AppUtils.languageTranslate('moveOut');
    }
    if (applicationType == "WP") {
      requestName = AppUtils.languageTranslate('workPermit');
    }
    if (applicationType == "FO") {
      requestName = AppUtils.languageTranslate('fitOut');
    }
    if (applicationType == "HB") {
      requestName = AppUtils.languageTranslate('facilityBooking');
    }
    // if (applicationType == "TP") {
    //   requestName = "Transfer of Property";
    // }
    // if (applicationType == "CS") {}
    // if (applicationType == "RI") {
    //   requestName = "Resident Information";
    // }
    if (applicationType == "DP") {
      requestName = AppUtils.languageTranslate('deliveryPermit');
    }
    if (applicationType == "SS") {
      requestName = AppUtils.languageTranslate('shortStay');
    }
    return requestName;
  }

  static String? getNationalityName(String code) {
    return AppConstants.nationalityMap[code.toUpperCase()] ?? '';
  }

  static String languageTranslate(String key) {
    return tr(key);
  }

  static Future<void> completeServiceAction({
    required BuildContext context,
    required ServiceDetailsState state,
  }) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController idController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TypeItemModel? selectedDocumentType = AppConstants.documentTypes.first;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, changeState) {
            return CustomAlertDialogBox(
              insetPadding: AppUtils.isTablet(context)
                  ? const EdgeInsets.symmetric(horizontal: 35)
                  : const EdgeInsets.symmetric(horizontal: 10),
              title:
                  '${AppUtils.languageTranslate('complete')} ${state.serviceDetails?.reference ?? ""}',
              disableFirstButtonBorder: true,
              firstButtonTextColor: AppColors.white,
              firstButtonColor: AppColors.primary,
              horizontalPadding: 8,
              firstButtonText: selectedDocumentType?.value == 'Emirates ID'
                  ? AppUtils.languageTranslate('scanEmiratesId')
                  : selectedDocumentType?.value == 'Photo ID'
                      ? AppUtils.languageTranslate('scanPhotoId')
                      : AppUtils.languageTranslate('scanTravelDocument'),
              secondButtonText: AppUtils.languageTranslate('complete'),
              secondButtonColor: AppColors.green,
              onFirstButtonPressed: () async {
                if (selectedDocumentType?.value == 'Emirates ID') {
                  EmiratesIdModel? emiratesIdData =
                      await ScannerService().scanEmiratesIdAndPerformOcr();
                  if (emiratesIdData != null) {
                    nameController.text = emiratesIdData.name ?? '';
                    idController.text = emiratesIdData.idNumber ?? '';
                  }
                } else if (selectedDocumentType?.value == 'Photo ID') {
                  DrivingLicenseModel? drivingLicenseDate =
                      await ScannerService().scanDrivingLicenseAndPerformOcr();
                  if (drivingLicenseDate != null) {
                    nameController.text = drivingLicenseDate.name ?? '';
                    idController.text = drivingLicenseDate.licenseNumber ?? '';
                  }
                } else {
                  PassportModel? passportData =
                      await ScannerService().scanPassportAndPerformOcr();
                  if (passportData != null) {
                    nameController.text = passportData.name ?? '';
                    idController.text = passportData.passportNumber ?? '';
                  }
                }

                return false;
              },
              onSecondButtonPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  final result =
                      await context.read<ServiceDetailsCubit>().completeService(
                    context,
                    data: {
                      'id': '${state.serviceDetails?.id}',
                      'requester_name': nameController.text,
                      'id_number': idController.text,
                      'note': noteController.text,
                    },
                  );

                  if (result) {
                    noteController.clear();
                    idController.clear();
                    nameController.clear();
                  }

                  return result;
                }
                return false;
              },
              contentBuilder: (dialogContext, setState) {
                return Form(
                  key: formKey,
                  child: Column(
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
                        label: AppUtils.languageTranslate('requesterName'),
                        controller: nameController,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return AppUtils.languageTranslate(
                                'fieldIsMandatory');
                          }
                          return null;
                        },
                      ),
                      const Gap(5),
                      TextFieldWidget(
                        label: '${AppUtils.languageTranslate('idNumber')} *',
                        controller: idController,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return AppUtils.languageTranslate(
                                'fieldIsMandatory');
                          }
                          return null;
                        },
                      ),
                      const Gap(5),
                      TextFieldWidget(
                        controller: noteController,
                        label: AppUtils.languageTranslate('servicesNote'),
                      ),
                      const Gap(5),
                      SingleSelectedDropdownWidget<TypeItemModel>(
                        label: AppUtils.languageTranslate('type'),
                        hint: AppUtils.languageTranslate('selectType'),
                        isClearButtonVisible: false,
                        fillColor: AppColors.white,
                        selectedItem: selectedDocumentType,
                        compareFn: (p0, p1) => p0.value == p1.value,
                        items: AppConstants.documentTypes,
                        itemAsString: (item) => item.label,
                        onChanged: (value) {
                          changeState(() {
                            selectedDocumentType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return AppUtils.languageTranslate('required');
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  static Future<void> addLogServiceAction({
    required BuildContext context,
    required ServiceDetailsState state,
  }) async {
    final TextEditingController noteController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          isFirstButtonDisable: true,
          insetPadding: AppUtils.isTablet(context)
              ? const EdgeInsets.symmetric(horizontal: 35)
              : const EdgeInsets.symmetric(horizontal: 10),
          title:
              '${AppUtils.languageTranslate('addLogTo')} ${state.serviceDetails?.reference ?? ""}',
          secondButtonText: AppUtils.languageTranslate('addLog'),
          secondButtonColor: AppColors.cyanBlue,
          onSecondButtonPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              final result =
                  await context.read<ServiceDetailsCubit>().addServiceLog(
                context,
                data: {
                  'application_id': '${state.serviceDetails?.id}',
                  'note': noteController.text,
                },
              );

              if (result) {
                noteController.clear();
              }

              return result;
            }
            return false;
          },
          contentBuilder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(5),
                  SvgPicture.asset(
                    AppImages.question,
                    height: 35,
                    width: 35,
                    colorFilter: const ColorFilter.mode(
                      AppColors.cyanBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(5),
                  TextFieldWidget(
                    controller: noteController,
                    label: AppUtils.languageTranslate('note'),
                    maxLength: 1000,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return AppUtils.languageTranslate('fieldIsMandatory');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class TypeModel {
  final String label;
  final String value;

  TypeModel({required this.label, required this.value});
}

class RangeOption {
  final String label;
  final String value;

  RangeOption(this.label, this.value);
}
