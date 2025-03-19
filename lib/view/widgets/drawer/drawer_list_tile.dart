import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
          )),
      contentPadding:const EdgeInsets.symmetric(horizontal: 10.0),
      leading: Container(
        padding: const EdgeInsets.all(3.0),
        // decoration: BoxDecoration(
        //   color: isSelected ? AppColors.primary : Colors.transparent,
        //   borderRadius: BorderRadius.circular(5.0),
        //   // border: Border.all(color: AppColors.lightGrey, width: 0.25),
        // ),
        child: SvgPicture.asset(
          iconPath,
          width: 22,
          height: 22,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.primary : AppColors.drawerColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.drawerColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
