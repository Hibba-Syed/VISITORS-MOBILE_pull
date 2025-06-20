import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
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
          Expanded(
            child: Container(
              alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal:  12,vertical: verticalPadding ?? 15),
                decoration: const BoxDecoration(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(5),
                     bottomLeft: Radius.circular(5),
                   ),
                  color:AppColors.lightYellow,
                ),
                child: Text(count?.toString() ?? "",style: TextStyle(
                    fontSize: AppUtils.isTablet(context)  ? 15 : 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white
                ),
                )),
          ),
          Container(
            alignment: Alignment.center,
           padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10,vertical: verticalPadding ?? 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: AppColors.yellow,
            ),
            child:  Text("Visitor Passes",
              style: TextStyle(
                fontSize:  AppUtils.isTablet(context)  ? 15 : 14,
                  fontWeight: FontWeight.w600,
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