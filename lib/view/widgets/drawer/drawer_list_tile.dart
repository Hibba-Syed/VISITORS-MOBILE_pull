import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../resource/constants/app_colors.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isSelected;
  const DrawerListTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.transparent,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(
            color: Colors.transparent,
          )),
      contentPadding:const EdgeInsets.symmetric(horizontal: 10.0),
      leading: Container(
        padding: const EdgeInsets.all(3.0),
        child: SvgPicture.asset(
          iconPath,
          width: AppUtils.isTablet(context)  ? 30 : 22,
          height: AppUtils.isTablet(context)  ? 30 : 22,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.primary : AppColors.darkGrey,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.darkGrey,
          fontSize:  AppUtils.isTablet(context)  ? 21 : 16,
          //MediaQuery.of(context).size.width < 600 ? 16 : 25,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
