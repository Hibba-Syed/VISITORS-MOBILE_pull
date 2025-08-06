import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
import '../text field/text_field_widget.dart';

class DateRangePickerField extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final TextEditingController controller;
  final Function(DateTimeRange)? onDateRangeSelected;

  const DateRangePickerField({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.onDateRangeSelected,
    required this.controller,
  });

  @override
  State<DateRangePickerField> createState() => _DateRangePickerFieldState();
}

class _DateRangePickerFieldState extends State<DateRangePickerField> {
  DateTimeRange? _selectedRange;

  void _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDateRange: _selectedRange,
      keyboardType: (MediaQuery.of(context).size.width<600)?TextInputType.datetime:TextInputType.visiblePassword,
    );

    if (picked != null) {
      setState(() {
        _selectedRange = picked;
        widget.controller.text =
        "${DateFormat('dd MMM yyyy').format(picked.start)} - ${DateFormat('dd MMM yyyy').format(picked.end)}";
      });

      if (widget.onDateRangeSelected != null) {
        widget.onDateRangeSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      readOnly: true,
      hint: AppUtils.languageTranslate("dateRange"),
      controller: widget.controller,
      keyboardType: TextInputType.datetime,
      textStyle: TextStyle(
        fontSize: 15,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      // hintStyle: const TextStyle(
      //   fontSize: 14,
      //   color: Colors.grey,
      // ),,
      onTap: _pickDateRange,
      suffix: Icon(Icons.calendar_month_sharp,size: 20,color: AppColors.darkGrey,),
    );
  }
}


// class CustomDateRangePickerWidget extends StatefulWidget {
//   final String? hintText;
//   final DateTimeRange? selectedDateRange;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final Function(DateTimeRange? value)? onChangeDateRange;
//   const CustomDateRangePickerWidget(
//       {super.key,
//       this.hintText,
//       this.selectedDateRange,
//       this.onChangeDateRange,
//       this.firstDate,
//       this.lastDate});
//
//   @override
//   State<CustomDateRangePickerWidget> createState() =>
//       _CustomDateRangePickerWidgetState();
// }
//
// class _CustomDateRangePickerWidgetState
//     extends State<CustomDateRangePickerWidget> {
//   DateTimeRange? _selectedDateRange;
//   @override
//   void initState() {
//     setState(() {
//       _selectedDateRange = widget.selectedDateRange;
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       onTap: () async {
//         await showDateRangePicker(
//                 barrierColor: AppColors.primary,
//                 context: context,
//                 currentDate: DateTime.now(),
//                 initialDateRange: widget.selectedDateRange,
//                 firstDate: widget.firstDate ??
//                     DateTime(DateTime.now().year - 100, 01, 01),
//                 lastDate: widget.lastDate ??
//                     DateTime((DateTime.now().year + 100), 01, 01))
//             .then((value) {
//           if (value == null) return;
//           setState(() {
//             _selectedDateRange = value;
//           });
//           widget.onChangeDateRange?.call(_selectedDateRange);
//         });
//       },
//       child: Container(
//         height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         width: double.maxFinite,
//         alignment: Alignment.centerLeft,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7),
//             border: Border.all(
//               color: AppColors.outLineGray,
//             )),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               textAlign: TextAlign.left,
//             _selectedDateRange != null  ? DateTimeUtil.getFormatDateRange(_selectedDateRange) : widget.hintText?.toString() ?? "Select",
//               // _selectedDateRange?.toString() ??
//               //     widget.hintText?.toString() ??
//               //     "Select",
//               style: const TextStyle(color: AppColors.darkGrey, fontSize: 13),
//             ),
//             SvgPicture.asset(
//               AppImages.date,
//               height: 22,
//               width: 22,
//               fit: BoxFit.fill,
//               colorFilter: const ColorFilter.mode(
//                 AppColors.darkGrey,
//                 BlendMode.srcIn,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


