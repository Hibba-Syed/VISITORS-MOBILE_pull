import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/images.dart';


class CustomDateRangePickerWidget extends StatefulWidget {
  final String? hintText;
  final String? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(String? value)? onChangeDate;
  const CustomDateRangePickerWidget(
      {super.key, this.hintText, this.selectedDate, this.onChangeDate,this.firstDate, this.lastDate});

  @override
  State<CustomDateRangePickerWidget> createState() =>
      _CustomDateRangePickerWidgetState();
}

class _CustomDateRangePickerWidgetState
    extends State<CustomDateRangePickerWidget> {
  String? selectedDate;
  @override
  void initState() {
    selectedDate = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () async {
        await showDateRangePicker(
          barrierColor: AppColors.primary,
            context: context,
            currentDate: DateTime.now(),
            initialDateRange: (selectedDate?.isEmpty ?? true)
                ? null
                : (DateTimeRange(
                start: DateTime.parse(
                    selectedDate?.split("/").first ?? "--"),
                end: DateTime.parse(
                    selectedDate?.split("/").last ?? "--"))),
            firstDate: widget.firstDate?? DateTime(DateTime.now().year-100, 01, 01),
            lastDate: widget.lastDate ?? DateTime((DateTime.now().year + 100), 01, 01))
            .then((value) {
          if (value == null) return;
          setState(() {
            selectedDate =
            "${DateFormat("yyyy-MM-dd").format(value.start)}/${DateFormat("yyyy-MM-dd").format(value.end)}";
          });
          widget.onChangeDate?.call(selectedDate);
        });
      },
      child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: AppColors.gray,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.left,
                 selectedDate?.toString() ??
                    widget.hintText?.toString() ??
                    "Select",style: const TextStyle(
                color: AppColors.darkGrey,
                fontSize: 13
              ),

              ),
              SvgPicture.asset(
                AppImages.date,
                height: 22,
                width: 22,
                fit: BoxFit.fill,
                colorFilter: const ColorFilter.mode(
                  AppColors.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
            ],
          )),
    );
  }
}

