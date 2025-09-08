import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
import '../text field/text_field_widget.dart';

class DateRangePickerWidget extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final void Function(DateTimeRange?) onDateRangePicked;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateRangePickerWidget({
    super.key,
    this.initialDateRange,
    required this.onDateRangePicked,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  final TextEditingController _dateRangeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.initialDateRange != null) {
          _dateRangeController.text =
              '${DateFormat('dd-MM-yyyy').format(widget.initialDateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(widget.initialDateRange!.end)}';
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant DateRangePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDateRange != oldWidget.initialDateRange &&
        widget.initialDateRange != null) {
      _dateRangeController.text =
      '${DateFormat('dd-MM-yyyy').format(widget.initialDateRange!.start)} - ${DateFormat('dd-MM-yyyy').format(widget.initialDateRange!.end)}';

    }

    // Clear if the initialDate becomes null (e.g. reset)
    if (widget.initialDateRange == null && oldWidget.initialDateRange != null) {
      _dateRangeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      readOnly: true,
      hint: AppUtils.languageTranslate("dateRange"),
      controller: _dateRangeController,
      keyboardType: TextInputType.datetime,
      textStyle: TextStyle(
        fontSize: 15,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      onTap: () async {
        DateTimeRange? dateRange = await showDateRangePicker(
          context: context,
          initialDateRange: widget.initialDateRange,
          firstDate: widget.firstDate ?? DateTime(DateTime.now().year - 100),
          lastDate: widget.lastDate ?? DateTime(DateTime.now().year + 100),
        );
        widget.onDateRangePicked(dateRange);
        if (dateRange != null) {
          setState(() {
            _dateRangeController.text =
                '${DateFormat('dd-MM-yyyy').format(dateRange.start)} - ${DateFormat('dd-MM-yyyy').format(dateRange.end)}';
          });
        }
      },
      suffix: Container(
        width: 70,
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_dateRangeController.text.isNotEmpty)
              InkWell(
                onTap: () {
                  widget.onDateRangePicked(null);
                  setState(() {
                    _dateRangeController.clear();
                  });
                },
                child: Icon(
                  Icons.clear,
                  color: AppColors.darkGrey,
                  size: 17,
                ),
              ),
            Gap(16),
            Icon(
              Icons.calendar_month_sharp,
              size: 20,
              color: AppColors.darkGrey,
            ),
          ],
        ),
      ),
    );
  }
}
