import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';

import '../../../resource/styles/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final String title;
  final String? hint;
  final DateTime? initialDate;
  final void Function(DateTime?) onDatePicked;
  final DateTime? firstDate;
  final DateTime? lastDate;
  const CustomDatePicker({
    super.key,
    required this.title,
    this.hint = 'Select date',
    this.initialDate,
    required this.onDatePicked,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.initialDate != null) {
          _dateController.text =
              DateFormat('EEEE, dd MMMM, yyyy').format(widget.initialDate!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.style12Black600,
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                readOnly: true,
                controller: _dateController,
                hint: widget.hint,
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
                  widget.onDatePicked(date);
                  if (date != null) {
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
