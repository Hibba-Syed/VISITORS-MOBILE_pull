import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
class ActionsContainerWidget extends StatelessWidget {
  final String? title;
  final int? count;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? forGroundColor;
  final VoidCallback? actionOnTap;
  const ActionsContainerWidget({super.key,
    this.title,
    this.count,
    this.iconPath,
    this.backgroundColor,
    this.forGroundColor,
    this.actionOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: actionOnTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset(
                  iconPath ?? "",
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                const Gap(5),
                if (count != null && count! > 0)...[
                  Text(
                    count?.toString() ?? "",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: forGroundColor,
                        fontWeight: FontWeight.w600
                    ),
                    //AppTextStyles.style14white600,
                  ),
                ],
                Text( title ?? "",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: forGroundColor,
                      fontWeight: FontWeight.w600

                  ),
                  //AppTextStyles.style14white500
                ),

              ]),
        ),
      ),
    );
  }
}
