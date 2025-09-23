import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ActionsContainerWidget extends StatelessWidget {
  final String? title;
  final int? count;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? actionOnTap;
  final double? width;
  const ActionsContainerWidget({
    super.key,
    this.title,
    this.count,
    this.iconPath,
    this.backgroundColor,
    this.foregroundColor,
    this.actionOnTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: actionOnTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            iconPath ?? "",
            height: 30,
            width: 30,
            fit: BoxFit.fill,
          ),
          const Gap(5),
          Text(
            count?.toString() ?? "",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          FittedBox(
            child: Text(
              title ?? "",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
