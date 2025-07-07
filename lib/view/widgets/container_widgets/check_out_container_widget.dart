import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/details/check_ins_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

import '../../../model/check_ins/check_in_log_model.dart';
import '../loader/loader_widget.dart';

class CheckOutContainerWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? logDate;
  final String? logStatus;
  final String? visitorsCount;
  final String? logByValue;
  final String? logDescription;
  final VoidCallback checkOutAllOnPress;
  final VoidCallback? checkOutOnPress;
  //final Future<bool> Function(bool value)? checkOutOnPress;
  final bool? logIsLast;
  final double? horizontalPadding;
  const CheckOutContainerWidget({
    super.key,
    required this.controller,
    this.logDate,
    this.logStatus,
    this.logByValue,
    this.logDescription,
    required this.checkOutAllOnPress,
    this.checkOutOnPress,
    this.logIsLast = false,
    this.visitorsCount,
    this.horizontalPadding,
  });

  @override
  State<CheckOutContainerWidget> createState() => _CheckOutContainerWidgetState();
}

class _CheckOutContainerWidgetState extends State<CheckOutContainerWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final enteredCount = int.tryParse(widget.controller.text.trim());
    final availableCount = int.tryParse(widget.visitorsCount ?? '') ?? 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.visitorsCount?.toString() ?? "",
          style: AppTextStyles.style36Red500,
        ),
        const Gap(5),
        Form(
          key: _formKey,
          child: TextFieldWidget(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hint: AppUtils.languageTranslate('noOfVisitorsCheckingOut'),
            validator: (value){
              if ( (enteredCount??0) > availableCount) {
                return AppUtils.languageTranslate('enterValidCount');
              }
              return null;
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        const Gap(20),
        (widget.controller.text.isNotEmpty)
            ? Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      borderRadius: 6,
                      invert: true,
                      height: 42,
                      buttonColor: AppColors.red,
                  textColor: AppColors.red,
                      text: AppUtils.languageTranslate('checkout'),
                      onPressed: (){
                        widget.checkOutOnPress?.call();
                      }
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: CustomButton(
                      borderRadius: 6,
                      buttonColor: AppColors.red,
                      height: 42,
                      text: AppUtils.languageTranslate('checkoutAll'),
                      onPressed: widget.checkOutAllOnPress,
                    ),
                  ),
                ],
              )
            : CustomButton(
                borderRadius: 6,
                buttonColor: AppColors.red,
                height: 42,
                text: AppUtils.languageTranslate('checkoutAll'),
                onPressed: widget.checkOutAllOnPress,
              ),
        const Gap(10),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
           AppUtils.languageTranslate('checkInLog'),
            style: AppTextStyles.style16black600,
          ),
        ),
        const Divider(color: AppColors.gray),
         const Gap(10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 240),
          child: BlocBuilder<CheckInsDetailsCubit, CheckInsDetailsState>(
            builder: (context, state) {
              if(state.isLoading ) {
                return LoaderWidget();
              }
              if(state.checkInLogs?.isEmpty ?? true){
                EmptyWidget(text: AppUtils.languageTranslate('noDataAvailable'));
              }
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: state.checkInLogs?.length,
                itemBuilder: (context, index) {
                  CheckInLogs? checkInLog = state.checkInLogs?[index];
                  bool isLast = (state.checkInLogs?.length ?? 0) - 1 == index;
                  return ActivityLogWidget(
                      horizontalPadding: 0,
                      isLast: isLast ? true : false,
                      status: checkInLog?.status ?? "",
                      byValue:  "",
                      description: checkInLog?.description ?? "",
                      dateTime:
                          DateTimeUtil.getFormattedDateTime(checkInLog?.updatedAt));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
