import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
class CheckOutContainerWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? logDate;
  final String? logStatus;
  final String? logByValue;
  final String? logDescription;
  final VoidCallback checkOutAllOnPress;
  final VoidCallback checkOutOnPress;
   const CheckOutContainerWidget({super.key,
     required this.controller,
     this.logDate,
     this.logStatus,
     this.logByValue,
     this.logDescription,
     required this.checkOutAllOnPress,
     required this.checkOutOnPress

  });

  @override
  State<CheckOutContainerWidget> createState() => _CheckOutContainerWidgetState();
}

class _CheckOutContainerWidgetState extends State<CheckOutContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '3',
          style: AppTextStyles.style36Red500,
        ),
        const Gap(5),
        TextFieldWidget(
          controller: widget.controller,
          hint: 'No. of visitors checking-out',
          onChanged: (value) {
            setState(() {});
          },
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
                text: 'Check-Out',
                onPressed: widget.checkOutOnPress,
              ),
            ),
            const Gap(8),
            Expanded(
              child: CustomButton(
                borderRadius: 6,
                buttonColor: AppColors.red,
                height: 42,
                text: 'Check-Out All',
                onPressed: widget.checkOutAllOnPress,
              ),
            ),
          ],
        ) : CustomButton(
          borderRadius: 6,
          buttonColor: AppColors.red,
          height: 42,
          text: 'Check-Out All',
          onPressed: widget.checkOutAllOnPress,
        ),
        const Gap(10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Check-In Log',
            style: AppTextStyles.style14Black600,
          ),
        ),
        const Divider(color: AppColors.gray),
        const Gap(5),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 250),
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ActivityLogWidget(
                status: widget.logStatus ?? "",
                byValue: widget.logByValue ?? "",
                description: widget.logDescription,
                dateTime: DateTimeUtil.getFormattedDateTime(widget.logDate)
              );
            },
          ),
        ),
      ],
    );
  }
}
