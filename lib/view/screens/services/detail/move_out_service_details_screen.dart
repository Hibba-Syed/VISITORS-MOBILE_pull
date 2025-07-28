import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:image_picker/image_picker.dart';
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../widgets/empty_widget.dart';

class MoveOutServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const  MoveOutServiceDetailsScreen({super.key,required this.service});

  @override
  State<MoveOutServiceDetailsScreen> createState() => _MoveOutServiceDetailsScreenState();
}

class _MoveOutServiceDetailsScreenState extends State<MoveOutServiceDetailsScreen> {
 final TextEditingController _noteController = TextEditingController();
 final TextEditingController _nameController = TextEditingController();
 final TextEditingController _idController = TextEditingController();
  List<XFile>? selectedImages = [];
  String? filePath;
  bool? isPaymentReceived;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBarWidget(
          title: AppUtils.languageTranslate('serviceDetails'),
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding),
          child: SingleChildScrollView(
            child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
              builder: (context, state) {
                if(state.isLoading){
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /3),
                    child: LoaderWidget(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HeadingWidget(
                            heading: AppUtils.getRequestName(
                                state.serviceDetails?.applicationType ?? "--"),
                          ),
                        ),
                        StatusWidget(
                            status: state.serviceDetails?.status ?? "--"),
                      ],
                    ),
                    const Gap(3),
                    HeadingWidget(
                      heading: state.serviceDetails?.reference ?? "--",
                      style: AppTextStyles.style14Black600,
                    ),
                    const Gap(10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TitleValueRowDividerDetailsContainerWidget(
                              title: AppUtils.languageTranslate('requestedDate'),
                              value:
                          DateTimeUtil.getFormattedDateTime(
                              state.serviceDetails?.application?.moveDate),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('requestedTime'),
                            value: '${state.serviceDetails?.application?.moveTimeFrom ?? "--"} - ${state.serviceDetails?.application?.moveTimeTo ?? "--"}'
                                ,
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                              title: AppUtils.languageTranslate('emergencyNumber'),
                              value: state.serviceDetails?.application?.emergencyNumber ?? '--'
                          ),

                        ],
                      ),
                    ),
                    const Gap(20),
                     HeadingWidget(
                      heading: AppUtils.languageTranslate('applicantDetails'),
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TitleValueRowDividerDetailsContainerWidget(
                              title: AppUtils.languageTranslate('requesterType'),
                              value: state.serviceDetails?.clientType ?? "--"),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:AppUtils.languageTranslate('name'),
                            value: state.serviceDetails?.clientName ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('phone'),
                            value: state.serviceDetails?.clientPhone ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                            title:AppUtils.languageTranslate('email'),
                            value: state.serviceDetails?.clientEmail ?? "--",
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                     Text(
                      AppUtils.languageTranslate('activityLog'),
                      style: AppTextStyles.style20primary600,
                    ),
                    const Gap(10),
                    state.serviceDetails?.statusHistory?.isNotEmpty ?? true ?
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount:
                        state.serviceDetails?.statusHistory?.length ?? 0,
                        itemBuilder: (context, index) {
                          StatusHistory? statusHistory = state.serviceDetails?.statusHistory?[index];
                          bool isLast = (state.serviceDetails?.statusHistory?.length ?? 0) - 1 == index;
                          return ActivityLogWidget(
                            horizontalPadding: 8,
                            isLast: isLast,
                            status: (statusHistory?.status != 'Pending') ? statusHistory?.status ?? "" : "Request Received",
                            byValue:  (statusHistory?.user?.fullName != null && statusHistory!.user!.fullName!.isNotEmpty)
                                ? ' ${statusHistory.user?.fullName ?? ""}'
                                : " System",
                            description: statusHistory?.note
                                ?.replaceAll('\n\n', ' ')
                                .trim()
                                .split('.')
                                .first
                                .trim(),

                            dateTime: DateTimeUtil.getFormattedDateTime(statusHistory?.createdAt),
                          );
                        },

                      ),
                    ) : EmptyWidget(text: AppUtils.languageTranslate('noDataAvailable')),
                  ],
                );
              },
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
                    buttonColor: AppColors.cyanBlue,
                    text: AppUtils.languageTranslate('addLog'),
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {

                            return CustomAlertDialogBox(
                              isCancelButtonDisable: true,
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 35)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              title: 'Add Log to ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference ?? ""}',
                              confirmButtonText: AppUtils.languageTranslate('addLog'),
                              onConfirm: () async {
                                if (_noteController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: AppUtils.languageTranslate('pleaseTypeNoteFirst'));
                                  return false;
                                }
                                final result = await context
                                    .read<ServiceDetailsCubit>()
                                    .addServiceLog(
                                  context,
                                  data: {
                                    'application_id':
                                    '${context.read<ServiceDetailsCubit>().state.serviceDetails?.id}',
                                    'note': _noteController.text,
                                  },
                                );
                                _noteController.clear();

                                return result;
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
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      controller: _noteController,
                                      label:  AppUtils.languageTranslate('note')
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
              if(context
                  .read<ServiceDetailsCubit>()
                  .state
                  .serviceDetails?.application?.securityDeposit ==
                  null &&
                  context
                      .read<ServiceDetailsCubit>()
                      .state
                      .serviceDetails
                      ?.status?.toLowerCase() ==
                      'approved')...[
                const Gap(10),
                Expanded(
                    child: CustomButton(
                        buttonColor: AppColors.green,
                        text:  AppUtils.languageTranslate('complete'),
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return CustomAlertDialogBox(
                                  insetPadding: AppUtils.isTablet(context)
                                      ? EdgeInsets.symmetric(horizontal: 35)
                                      : EdgeInsets.symmetric(horizontal: 10),
                                  title:
                                  'Complete ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference ?? ""}',
                                  disableCancelButtonBorder: true,
                                  cancelButtonTextColor: AppColors.white,
                                  cancelButtonColor: AppColors.primary,
                                  cancelButtonText:  AppUtils.languageTranslate('scanId'),
                                  confirmButtonText: AppUtils.languageTranslate('complete'),
                                  confirmButtonColor: AppColors.green,
                                  onConfirm: () async {
                                    if (_nameController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: AppUtils.languageTranslate('pleaseTypeNameFirst'));
                                      return false;
                                    }
                                    if (_idController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: AppUtils.languageTranslate('pleaseTypeIdFirst'));
                                      return false;
                                    }
                                    final result = await context
                                        .read<ServiceDetailsCubit>()
                                        .completeService(
                                      context,
                                      data: {
                                        'id':
                                        '${context.read<ServiceDetailsCubit>().state.serviceDetails?.id}',
                                        'requester_name':
                                        _nameController.text,
                                        'id_number': _idController.text,
                                        'note': _noteController.text,
                                      },
                                    );
                                    if(result){
                                      _noteController.clear();
                                      _idController.clear();
                                      _nameController.clear();
                                    }
                                    return result;
                                  },
                                  contentBuilder: (context, setState) {
                                    return Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
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
                                          label:  AppUtils.languageTranslate('requesterName'),
                                          controller: _nameController,
                                        ),
                                        const Gap(5),
                                        TextFieldWidget(
                                          label: AppUtils.languageTranslate('idNumber'),
                                          controller: _idController,
                                        ),
                                        const Gap(5),
                                        TextFieldWidget(
                                          controller: _noteController,
                                          label: AppUtils.languageTranslate('note'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                        })
                ), ],

              if(context.read<ServiceDetailsCubit>().state.serviceDetails?.status?.toLowerCase() != 'approved')...[
                const Gap(10),
                Expanded(
                  child: CustomButton(
                      buttonColor: AppColors.yellow,
                      text:  AppUtils.languageTranslate('clearPayment'),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialogBox(
                                insetPadding: AppUtils.isTablet(context)
                                    ? EdgeInsets.symmetric(horizontal: 35)
                                    : EdgeInsets.symmetric(horizontal: 10),
                                isCancelButtonDisable: true,
                                title: 'Clear Payment for ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference}',
                                disableCancelButtonBorder: true,
                                confirmButtonText:  AppUtils.languageTranslate('clearPayment'),
                                confirmButtonColor: AppColors.yellow,
                                onConfirm: () async {
                                  if (selectedImages?.isEmpty ?? false) {
                                    Fluttertoast.showToast(
                                        msg: AppUtils.languageTranslate('pleaseChooseImageFileFirst'));
                                    return false;
                                  }
                                  if (isPaymentReceived == null) {
                                    Fluttertoast.showToast(
                                        msg:  AppUtils.languageTranslate('pleaseSelectCheckboxFirst'));
                                    return false;
                                  }
                                  final filePaths = selectedImages
                                      ?.where((file) => file.path.isNotEmpty)
                                      .map((file) => file.path)
                                      .toList();
                                  final result = await context
                                      .read<ServiceDetailsCubit>()
                                      .clearPayment(
                                    context,
                                    id: context.read<ServiceDetailsCubit>().state.serviceDetails?.id,
                                    file: filePaths,
                                    data: {
                                      'payment_received': isPaymentReceived,
                                      'note': _noteController.text,
                                    },
                                  );
                                  // noteController.clear();
                                  return result;
                                },
                                contentBuilder: (context, setState) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Gap(5),
                                      Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          AppImages.question,
                                          height: 35,
                                          width: 35,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.yellow,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      TextFieldWidget(
                                        controller: _noteController,
                                        label: AppUtils.languageTranslate('note'),
                                      ),
                                      const Gap(5),
                                      Text(AppUtils.languageTranslate('chequeFile'),style: AppTextStyles.style14Black600),
                                      const Gap(10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              (filePath?.isNotEmpty ?? true)
                                                  ? selectedImages?.firstOrNull?.name??""
                                                  : AppUtils.languageTranslate('chooseFile'),
                                              style: AppTextStyles.style14darkGrey400,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          InkWell(
                                            overlayColor:
                                            const WidgetStatePropertyAll(Colors.transparent),
                                            onTap: () async {
                                              if ((selectedImages?.length ?? 0) >= 1) {
                                                Fluttertoast.showToast(
                                                    msg:  AppUtils.languageTranslate('cannotSelectMultipleFiles'));
                                                return;
                                              }
                                              await FilePicker.platform
                                                  .pickFiles(allowMultiple: false)
                                                  .then((FilePickerResult? result) {
                                                if (result != null && result.files.isNotEmpty) {
                                                  selectedImages
                                                      ?.addAll(result.files.map((e) => e.xFile));
                                                  setState(() {});
                                                }
                                                return null;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                color: AppColors.cyanBlue,
                                                border: Border.all(color: AppColors.outLineGray, width: 0.5),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: AppColors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                              height: 25,
                                              child: Checkbox(
                                                  fillColor: WidgetStateProperty.all(AppColors.cyanBlue),
                                                  side: BorderSide(color: AppColors.gray, width: 2),
                                                  value: isPaymentReceived??false,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isPaymentReceived = value;
                                                    });
                                                  })),
                                           Text( AppUtils.languageTranslate('paymentReceived'),style: AppTextStyles.style14Black600,
                                          ),
                                        ],
                                      ),

                                    ],
                                  );
                                },
                              );
                            });
                      }),
                )
              ]

            ],
          ),
        ),
      ),
    );
  }
}
