import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
class VisitorPassesButton extends StatelessWidget {
  final int? count;
  final double? horizontalPadding;
  final double? verticalPadding;
  final VoidCallback? onPressed;
  const VisitorPassesButton({super.key,
    this.count,
    this.horizontalPadding,
    this.verticalPadding,
    this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 40,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10,vertical: verticalPadding ?? 10),
              decoration: const BoxDecoration(
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(5),
                   bottomLeft: Radius.circular(5),
                 ),
                color:AppColors.lightYellow,
              ),
              child: Text(count?.toString() ?? "",style:const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white
              ),
              )),
          Container(
            alignment: Alignment.center,
            // width: 120,
           padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10,vertical: verticalPadding ?? 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: AppColors.yellow,
            ),
            child: const Text("Visitor Passes",
              style: TextStyle(
                fontSize: 14,
                  fontWeight: FontWeight.w500,
                 color: AppColors.white
              ),
              // AppTextStyles.style15white600

            ),
          ),
        ],
      ),
    );
  }
}