import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/styles/styles.dart';

import '../../../resource/constants/app_colors.dart';
class LogoutButton extends StatelessWidget {
  final Color? backgroundColor;
  final String? image;
  final String? text;
  final VoidCallback? onPressed;
  final double? width;
  const LogoutButton({super.key,
    this.backgroundColor,
    this.image,
    this.onPressed,
    this.width,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onPressed,
      child: Container(
        height: 35,
        width: width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.red,
          borderRadius:  BorderRadius.circular(5)
        ),
        child:  Row(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image ?? "",
              height: 16,
              width: 16,
              colorFilter: const ColorFilter.mode(
               AppColors.white,
              BlendMode.srcIn,
            ),
            ),
            const Gap(10),
            Text(text ?? 'button text',style: AppTextStyles.style15white600,)
          ],
        ),
      ),
    );
  }
}
