import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
import '../loader/loader_widget.dart';

class CustomAlertDialogBox extends StatefulWidget {
  final String? title;
  final String? cancelButtonText;
  final String? confirmButtonText;
  final Future<bool> Function()?
  onConfirm;
  final Future<bool?> Function()? onCancel;
  final Widget Function(BuildContext, void Function(void Function()))?
  contentBuilder;
  final bool showCloseIcon;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final bool? hideBothButtons;
  final double? horizontalPadding;
  final bool? disableCancelButtonBorder;
  final Color? cancelButtonTextColor;
  final Color? confirmButtonTextColor;
  final EdgeInsets? insetPadding;
  final bool isCancelButtonDisable;
  final bool? canPopOnConfirm;
  final String? customSubTitleText;

  const CustomAlertDialogBox({
    super.key,
    this.title,
    this.cancelButtonText = "Cancel",
    this.confirmButtonText = "Confirm",
    this.onConfirm,
    this.onCancel,
    this.contentBuilder,
    this.showCloseIcon = true,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.horizontalPadding,
    this.hideBothButtons = false,
    this.disableCancelButtonBorder = false,
    this.cancelButtonTextColor,
    this.confirmButtonTextColor,
    this.insetPadding,
    this.isCancelButtonDisable = false,
    this.canPopOnConfirm = true,
    this.customSubTitleText,
  });

  @override
  CustomAlertDialogBoxState createState() => CustomAlertDialogBoxState();
}

class CustomAlertDialogBoxState extends State<CustomAlertDialogBox> {
  bool isLoading = false;
  bool isCancelLoading = false;

  Future<void> _handleConfirm() async {
    if (widget.onConfirm != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() => isLoading = true);
      bool success = await widget.onConfirm!();
      setState(() => isLoading = false);
      if (success && (widget.canPopOnConfirm ?? true)) {
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } else {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleCancel() async {
    if (widget.onCancel != null) {
      setState(() => isCancelLoading = true);
      bool? success = await widget.onCancel!();
      setState(() => isCancelLoading = false);
      if (success ?? true) {
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColors.white,
      insetPadding: widget.insetPadding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height *
                  0.8, // Limits height to 80% of the screen
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.title?.isNotEmpty ?? false) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title ?? "--",style:  const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),

                              ),
                              const Gap(5),
                              if (widget.customSubTitleText?.isNotEmpty ??
                                  false)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.customSubTitleText ?? "--",style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.darkGrey
                                  ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                      if (widget.showCloseIcon)
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child:
                             Icon(
                              Icons.close,
                              color: Colors.grey,
                               size: AppUtils.isTablet(context) ? 30 : 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title?.isNotEmpty ?? false) ...[
                            const SizedBox(height: 15),
                          ],
                          widget.contentBuilder != null
                              ? widget.contentBuilder!(context, setState)
                              : const Text(
                            "Are you sure you want to proceed with this action?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (widget.hideBothButtons == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (!(widget.isCancelButtonDisable)) ...[
                                  Expanded(
                                    child: isCancelLoading
                                        ? const Center(child: LoaderWidget())
                                        : TextButton(
                                      onPressed: (widget.onCancel != null)
                                          ? _handleCancel
                                          : () =>
                                          Navigator.of(context).pop(),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                        widget.cancelButtonColor ??
                                            Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widget
                                                .horizontalPadding ??
                                                24,
                                            vertical:  12
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          side: BorderSide(
                                              color:
                                              (widget.disableCancelButtonBorder ??
                                                  false)
                                                  ? Colors.transparent
                                                  : AppColors.darkGrey),
                                        ),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        widget.cancelButtonText!,
                                        style: TextStyle(
                                            color: widget
                                                .cancelButtonTextColor ??
                                                Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                Expanded(
                                  child: isLoading
                                      ? const Center(child: LoaderWidget())
                                      : TextButton(
                                    onPressed: _handleConfirm,
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                      widget.confirmButtonColor ??
                                          AppColors.primary,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          widget.horizontalPadding ??
                                              24,
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      widget.confirmButtonText ?? "Yes",
                                      style: TextStyle(
                                          color: widget
                                              .confirmButtonTextColor ??
                                              Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
