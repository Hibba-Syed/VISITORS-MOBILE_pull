import 'package:flutter/material.dart';

import '../../resource/constants/app_colors.dart';
import '../../utils/app_utils.dart';

class MobileWebIconWidget extends StatelessWidget {
  final bool isMobile;
  final bool isDecorationEnabled;
  final Color? iconColor;
  const MobileWebIconWidget({
    super.key,
    required this.isMobile,
    this.isDecorationEnabled = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isMobile == true
          ? AppUtils.languageTranslate("mobile_check_in")
          : AppUtils.languageTranslate("web_check_in"),
      child: Container(
        padding: isDecorationEnabled
            ?  EdgeInsets.symmetric(vertical: AppUtils.isTablet(context)?7:6, horizontal: 10)
            : null,
        decoration: isDecorationEnabled
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.primary)
            : null,
        child: Icon(
          isMobile == true ? Icons.phone_iphone : Icons.desktop_mac_outlined,
          color: iconColor ?? AppColors.lightGrey,
          size: 19,
        ),
      ),
    );
  }
}
