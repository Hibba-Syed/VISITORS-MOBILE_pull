import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

import '../../../resource/styles/styles.dart';
import '../../../utils/app_utils.dart';

class DatePickerWidget extends StatefulWidget {
  final String? label;
  final String? hint;
  final DateTime? initialDate;
  final void Function(DateTime?) onDatePicked;
  final DateTime? firstDate;
  final DateTime? lastDate;
  const DatePickerWidget({
    super.key,
    this.label,
    this.hint,
    this.initialDate,
    required this.onDatePicked,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _dateController.text =
          DateFormat('EEEE, dd MMMM, yyyy').format(widget.initialDate!);
    }
  }

  @override
  void didUpdateWidget(covariant DatePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialDate != oldWidget.initialDate &&
          widget.initialDate != null) {
        _dateController.text =
            DateFormat('EEEE, dd MMMM, yyyy').format(widget.initialDate!);
      }

      // Clear if the initialDate becomes null (e.g. reset)
      if (widget.initialDate == null && oldWidget.initialDate != null) {
        _dateController.clear();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label?.isNotEmpty ?? false) ...[
          Text(
            widget.label!,
            style: AppUtils.isTablet(context)
                ? AppTextStyles.style15DarkGrey600
                : AppTextStyles.style13DarkGrey600,
          ),
          const Gap(8),
        ],
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                readOnly: true,
                controller: _dateController,
                hint: (widget.hint?.isNotEmpty ?? false)
                    ? widget.hint
                    : AppUtils.languageTranslate('selectDate'),
                suffix: const Icon(Icons.date_range),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: widget.initialDate,
                    firstDate:
                        widget.firstDate ?? DateTime(DateTime.now().year - 100),
                    lastDate:
                        widget.lastDate ?? DateTime(DateTime.now().year + 100),
                  );

                  if (date != null) {
                    widget.onDatePicked(date);
                    setState(() {
                      _dateController.text =
                          DateFormat('EEEE, dd MMMM, yyyy').format(date);
                    });
                  }
                },
              ),
            ),
            if (_dateController.text.isNotEmpty)
              InkWell(
                onTap: () {
                  widget.onDatePicked(null);
                  setState(() {
                    _dateController.clear();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 6.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.clear,
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
