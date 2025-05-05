import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/styles/styles.dart';
import '../../../utils/validation_util.dart';

class SearchTextField extends StatelessWidget {
  final String? initialValue;
  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onFilterPressed;
  final bool isFilterApplied;
  final Color? fillColor;
  final IconData? suffixIcon;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onClearPressed;
  const SearchTextField(
      {super.key,
      this.initialValue,
      this.hint = 'Search by keyword',
      this.controller,
      this.onChanged,
      this.onFieldSubmitted,
      this.onFilterPressed,
      this.isFilterApplied = false,
      this.fillColor,
      this.onSearchPressed,
      this.onClearPressed,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              initialValue: initialValue,
              controller: controller,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                hintText: hint,
                hintStyle: AppTextStyles.style12darkGrey400,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: controller?.text.isNotEmpty == true
                    ? GestureDetector(
                        onTap: () {
                          if (onClearPressed != null) {
                            onClearPressed!();
                          }
                          // Clear the controller which will trigger a rebuild
                          controller?.clear();
                        },
                        child: Icon(
                          suffixIcon ?? Icons.clear,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      )
                    : null,
                prefixIcon: GestureDetector(
                  onTap: onSearchPressed,
                  child: const Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                ),
                alignLabelWithHint: false,
                fillColor: fillColor ?? AppColors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    color: AppColors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    color: AppColors.white,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    color: AppColors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 0.0,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (onFilterPressed != null) const Gap(10),
        if (onFilterPressed != null)
          Stack(
            children: [
              InkWell(
                onTap: onFilterPressed,
                child: Container(
                  width: 48.0,
                  height: getHeight(context),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              if (isFilterApplied)
                const Positioned(
                  right: 10.0,
                  top: 10.0,
                  child: Icon(
                    Icons.circle,
                    color: AppColors.green,
                    size: 10.0,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  double getHeight(BuildContext context) {
    //double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    double textScaleFactor = MediaQuery.of(context).devicePixelRatio;
    if (textScaleFactor == 1.1) {
      return 49.0;
    } else if (textScaleFactor == 1.3) {
      return 52.0;
    } else if (textScaleFactor == 1.5) {
      return 56.8;
    } else if (textScaleFactor == 1.7) {
      return 58.0;
    }
    return 48.0;
  }
}
