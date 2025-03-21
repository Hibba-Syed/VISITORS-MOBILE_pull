import 'package:flutter/material.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/styles/styles.dart';
import '../../../utils/validation_util.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool isBackButtonEnabled;
  final Color titleColor;
  final Color backgroundColor;
  final Color iconColor;
  final double? height;
  final bool isNotificationEnabled;

  const AppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.onBackPressed,
    this.isBackButtonEnabled = true,
    this.titleColor = AppColors.lightGrey,
    this.backgroundColor = AppColors.white,
    this.iconColor = AppColors.lightGrey,
    this.height,
    this.isNotificationEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: backgroundColor,
      leadingWidth: 50,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: leading ??
              (isBackButtonEnabled
                  ? IconButton(
                      onPressed: onBackPressed ??
                          () {
                            Navigator.pop(context);
                          },
                      icon: Icon(
                        Icons.arrow_back,
                        color: iconColor,
                        size: 24.0,
                      ),
                    )
                  : null)),
      title: ValidationUtil.isValid(title)
          ? Text(title!, style:
      AppTextStyles.style20black600
      )
          : null,
      actions: actions ??
          (isNotificationEnabled
              ? [
                  IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.notifications);
                      // context.read<DashboardCubit>().onChangeIsFloatingButtonExpanded(false);
                    },
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: iconColor,
                    ),
                  ),
                ]
              : null),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
