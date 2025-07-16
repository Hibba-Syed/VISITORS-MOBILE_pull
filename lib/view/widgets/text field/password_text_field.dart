import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';

class PasswordTextField extends StatefulWidget {
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
  final bool readOnly;
  final int? maxLength;
  final bool expands;
  final Color? fillColor;
  const PasswordTextField({
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
    this.readOnly = false,
    this.maxLength,
    this.expands = false,
    this.fillColor,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label?.isNotEmpty ?? false)
          Text(
            widget.label!,
            style: AppTextStyles.style12darkGrey400,
          ),
        if (widget.label?.isNotEmpty ?? false) Gap(8.0),
        TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onEditingComplete: widget.onEditingComplete,
          onSaved: widget.onSaved,
          inputFormatters: widget.inputFormatters ?? [],
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          obscureText: _isObscure,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          expands: widget.expands,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            hintText: widget.hint,
            hintStyle: AppUtils.isTablet(context) ? AppTextStyles.style15DarkGrey400 : AppTextStyles.style14darkGray400,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder:
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                width: 0.0,
                color: AppColors.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: AppColors.outLineGray, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color:  AppColors.outLineGray, width: 1),
            ),
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child:
              SvgPicture.asset(
                AppImages.loginLock,
                colorFilter:
                    const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                fit: BoxFit.scaleDown,
              ),
             ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              child: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
            ),
            alignLabelWithHint: false,
            fillColor: widget.fillColor ?? AppColors.white,
            filled: true,
          ),

        )
      ],
    );
  }
}
