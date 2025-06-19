import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';

class TextFieldWidget extends StatelessWidget {
  final String? initialValue;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final bool expands;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final Color? outLineColor;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final AutovalidateMode? autovalidateMode;

  const TextFieldWidget({
    super.key,
    this.initialValue,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.inputFormatters,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines,
    this.maxLength,
    this.expands = false,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.outLineColor,
    this.textStyle,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label?.isNotEmpty ?? false)
          Text(
            label!,
            style: AppUtils.isTablet(context)
                ? //const TextStyle(fontSize: 15, color: AppColors.DarkGrey,fontWeight: FontWeight.w500)
            AppTextStyles.style15DarkGrey600
                : AppTextStyles.style13DarkGrey600,
          ),
        if (label?.isNotEmpty ?? false) const Gap(8.0),
        TextFormField(
          initialValue: initialValue,
          controller: controller,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          inputFormatters: inputFormatters ?? [],
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          maxLength: maxLength,
          expands: expands,
          style: textStyle,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            hintText: hint,
            hintStyle: AppUtils.isTablet(context)
                ? AppTextStyles.style14darkGrey400
                : AppTextStyles.style13darkGray400,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: prefix,
            suffixIcon: suffix,
            alignLabelWithHint: false,
            fillColor: fillColor ?? AppColors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                width: 0.0,
                color: AppColors.primary,
              ),
            ),
            //focusedBorder,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: outLineColor ?? AppColors.outLineGray, width: 1),
            ),
            //enabledBorder,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
            //errorBorder,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: outLineColor ?? AppColors.outLineGray, width: 1),
              //focusedErrorBorder,
            ),
          ),
        ),
      ],
    );
  }
}
