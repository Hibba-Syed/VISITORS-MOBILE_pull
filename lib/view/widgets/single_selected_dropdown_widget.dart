import 'package:dropdown_search/dropdown_search.dart'
    show
        ClearButtonProps,
        DropDownDecoratorProps,
        DropdownButtonProps,
        DropdownSearch,
        DropdownSuffixProps,
        PopupProps,
        TextFieldProps;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';

class SingleSelectedDropdownWidget<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? selectedItem;
  final List<T> items;
  final String Function(T)? itemAsString;
  final bool Function(T, T)? compareFn;
  final void Function(T?)? onChanged;
  final bool enabled;
  final String? Function(T?)? validator;
  final Color? fillColor;
  final Color? outLineColor;

  const SingleSelectedDropdownWidget({
    super.key,
    this.label,
    this.hint,
    required this.selectedItem,
    required this.items,
    this.itemAsString,
    this.compareFn,
    required this.onChanged,
    this.enabled = true,
    this.validator,
    this.fillColor,
    this.outLineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label?.isNotEmpty ?? false)
          Text(label!,
              style: const TextStyle(fontSize: 16, color: AppColors.darkGrey)),
        if (label?.isNotEmpty ?? false) const Gap(8),
        DropdownSearch<T>(
          enabled: enabled,
          suffixProps: const DropdownSuffixProps(
            clearButtonProps: ClearButtonProps(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.clear,
                  size: 16,
                  color: AppColors.darkGrey,
                ),
                isVisible: true,
            ),
            dropdownButtonProps: DropdownButtonProps(
              iconClosed: Icon(
                Icons.keyboard_arrow_down_outlined,color: AppColors.darkGrey,
              ),
              iconOpened: Icon(
                Icons.keyboard_arrow_up_outlined,color: AppColors.darkGrey,
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 13, color: AppColors.darkGrey,fontWeight: FontWeight.w500),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              alignLabelWithHint: false,
              fillColor: fillColor ?? AppColors.white,
              filled: true,
              // border: border ?? InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide:  BorderSide(
                  color: outLineColor ?? AppColors.outLineGray,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: AppColors.gray,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
              ),
            ),
          ),
          selectedItem: selectedItem,
          items: (filter, infiniteScrollProps) => items,
          itemAsString: itemAsString,
          compareFn: compareFn,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              hintText: 'Search ',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: AppColors.gray,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                  color: AppColors.gray,
                ),
              ),
            )),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
