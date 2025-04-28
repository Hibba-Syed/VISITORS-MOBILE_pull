import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../resource/constants/app_colors.dart';
import '../../../resource/styles/styles.dart';
class TypeContainerWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const TypeContainerWidget({super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: DottedBorder(
        strokeWidth: 1,
        dashPattern: [3, 3, 3, 3],
        borderType: BorderType.RRect,
        color: AppColors.primary,
        radius: Radius.circular(100),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: SizedBox(
            height: 90,
            width: 90,
            child:Column(
       mainAxisSize: MainAxisSize.min,
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.perm_contact_cal_outlined,color: AppColors.primary,size: 23,),
            Gap(5),
            Text(text,
              textAlign: TextAlign.center,
              style: AppTextStyles.style14Primary600,
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
