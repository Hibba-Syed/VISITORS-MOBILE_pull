import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
import '../loader/loader_widget.dart';

class CustomAlertDialogBox extends StatefulWidget {
  final String? title;
  final String? firstButtonText;
  final String? secondButtonText;
  final double? secondButtonTextFontSize;
  final FontWeight? secondButtonTextFontWeight;

  final Future<bool> Function()? onSecondButtonPressed;
  final Future<bool?> Function()? onFirstButtonPressed;
  final Widget Function(BuildContext, void Function(void Function()))?
      contentBuilder;
  final bool showCloseIcon;
  final Color? secondButtonColor;
  final Color? firstButtonColor;
  final bool? hideBothButtons;
  final double? horizontalPadding;
  final bool? disableFirstButtonBorder;
  final Color? firstButtonTextColor;
  final Color? secondButtonTextColor;
  final EdgeInsets? insetPadding;
  final bool isFirstButtonDisable;
  final bool? canPopOnSecondButtonPressed;
  final String? customSubTitleText;

  const CustomAlertDialogBox({
    super.key,
    this.title,
    this.firstButtonText,
    this.secondButtonText,
    this.onSecondButtonPressed,
    this.onFirstButtonPressed,
    this.contentBuilder,
    this.showCloseIcon = true,
    this.secondButtonColor,
    this.firstButtonColor,
    this.horizontalPadding,
    this.hideBothButtons = false,
    this.disableFirstButtonBorder = false,
    this.firstButtonTextColor,
    this.secondButtonTextColor,
    this.insetPadding,
    this.isFirstButtonDisable = false,
    this.canPopOnSecondButtonPressed = true,
    this.customSubTitleText,
    this.secondButtonTextFontSize,
    this.secondButtonTextFontWeight,
  });

  @override
  CustomAlertDialogBoxState createState() => CustomAlertDialogBoxState();
}

class CustomAlertDialogBoxState extends State<CustomAlertDialogBox> {
  bool isLoading = false;
  bool isFirstButtonLoading = false;

  Future<void> _handleSecondButtonOnPressed() async {
    if (widget.onSecondButtonPressed != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() => isLoading = true);
      bool success = await widget.onSecondButtonPressed!();
      setState(() => isLoading = false);
      if (success && (widget.canPopOnSecondButtonPressed ?? true)) {
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } else {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleFirstButtonOnPressed() async {
    if (widget.onFirstButtonPressed != null) {
      setState(() => isFirstButtonLoading = true);
      bool? success = await widget.onFirstButtonPressed!();
      setState(() => isFirstButtonLoading = false);
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
                                widget.title ?? "--",
                                style: const TextStyle(
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
                                    widget.customSubTitleText ?? "--",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.darkGrey),
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
                            child: Icon(
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
                              ? Stack(
                                  children: [
                                    widget.contentBuilder!(context, setState),
                                    if ((isLoading || isFirstButtonLoading))
                                      Positioned.fill(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          color: AppColors.transparent,
                                        ),
                                      ),
                                  ],
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppUtils.languageTranslate(
                                        'areYouSureYouWantToProceedWithThisAction'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          if (widget.hideBothButtons == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (!(widget.isFirstButtonDisable)) ...[
                                  Expanded(
                                    child: isFirstButtonLoading
                                        ? const Center(child: LoaderWidget())
                                        : TextButton(
                                            onPressed: (widget
                                                        .onFirstButtonPressed !=
                                                    null)
                                                ? _handleFirstButtonOnPressed
                                                : () =>
                                                    Navigator.of(context).pop(),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  widget.firstButtonColor ??
                                                      Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: widget
                                                          .horizontalPadding ??
                                                      24,
                                                  vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                side: BorderSide(
                                                    color:
                                                        (widget.disableFirstButtonBorder ??
                                                                false)
                                                            ? Colors.transparent
                                                            : AppColors
                                                                .darkGrey),
                                              ),
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              widget.firstButtonText ??
                                                  AppUtils.languageTranslate(
                                                      'cancel'),
                                              style: TextStyle(
                                                color: widget
                                                        .firstButtonTextColor ??
                                                    Colors.black,
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                Expanded(
                                  child: isLoading
                                      ? const Center(child: LoaderWidget())
                                      : TextButton(
                                          onPressed:
                                              _handleSecondButtonOnPressed,
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                widget.secondButtonColor ??
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
                                            widget.secondButtonText ??
                                                AppUtils.languageTranslate(
                                                    'confirm'),
                                            style: TextStyle(
                                                color: widget
                                                        .secondButtonTextColor ??
                                                    Colors.white,
                                                fontSize: widget
                                                        .secondButtonTextFontSize ??
                                                    14,
                                                fontWeight: widget
                                                        .secondButtonTextFontWeight ??
                                                    FontWeight.w600),
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
