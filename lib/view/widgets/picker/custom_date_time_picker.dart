import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';

class CustomDateTimePickerWidget extends StatefulWidget {
  final String? hintText;
  final String? selectedDateTime;
  final Function(String? value)? onChangeDateTime;
  final DateTime? initialDateTime;
  final DateTime? lastDateTime;
  final bool onlyDatePicker;
  final bool onlyTimePicker;
  final String timeFormat; // Add this field for custom time format.
  final Color? fillColor;

  const CustomDateTimePickerWidget({
    super.key,
    this.hintText,
    this.selectedDateTime,
    this.onChangeDateTime,
    this.initialDateTime,
    this.lastDateTime,
    this.onlyDatePicker = false,
    this.onlyTimePicker = false,
    this.timeFormat = "HH:mm", // Default format is 24-hour (e.g., "14:30").
    this.fillColor,
  });

  @override
  State<CustomDateTimePickerWidget> createState() =>
      _CustomDateTimePickerWidgetState();
}

class _CustomDateTimePickerWidgetState
    extends State<CustomDateTimePickerWidget> {
  String? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.selectedDateTime;
  }

  Future<void> _pickDateTime(BuildContext context) async {
    if (widget.onlyDatePicker) {
      // Pick Date Only
      final DateTime? pickedDate = await showDatePicker(

        context: context,
        initialDate: widget.initialDateTime ?? DateTime.now(),
        firstDate: widget.initialDateTime ?? DateTime(2000),
        lastDate:widget.lastDateTime ?? DateTime(2100),
      );
      if (pickedDate != null) {
        setState(() {
          selectedDateTime = DateFormat("yyyy-MM-dd").format(pickedDate);
        });
        widget.onChangeDateTime?.call(selectedDateTime);
      }
    } else if (widget.onlyTimePicker) {
      // Pick Time Only
      final TimeOfDay? pickedTime = await showTimePicker(

        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime now = DateTime.now();
        final DateTime formattedTime = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          selectedDateTime =
              DateFormat(widget.timeFormat).format(formattedTime);
        });
        widget.onChangeDateTime?.call(selectedDateTime);
      }
    } else {
      // Pick Date
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.initialDateTime ?? DateTime.now(),
        firstDate: widget.initialDateTime ?? DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (!context.mounted) return;
      if (pickedDate != null) {
        final String formattedDate =
            DateFormat("yyyy-MM-dd").format(pickedDate);
        // Pick Time
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          final DateTime formattedTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          setState(() {
            selectedDateTime =
                "$formattedDate ${DateFormat(widget.timeFormat).format(formattedTime)}";
          });
          widget.onChangeDateTime?.call(selectedDateTime);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () => _pickDateTime(context),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.maxFinite,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: AppColors.outLineGray,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDateTime ?? widget.hintText ?? "Select Date/Time",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const Icon(
              Icons.calendar_month_sharp,
              color: Colors.grey,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}
