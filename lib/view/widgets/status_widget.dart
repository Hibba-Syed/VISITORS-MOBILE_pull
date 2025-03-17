import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import '../../utils/text_utils.dart';
import 'custom_text.dart';

class StatusWidget extends StatelessWidget {
  final String status;
  final Color dotColor;
  final Color statusColor;
  final Color containerColor;
  final FontWeight? fontWeight;
  final bool? hideDot;
  const StatusWidget({
    super.key,
    required this.status,
    required this.dotColor,
    required this.statusColor,
    required this.containerColor,
    this.fontWeight,
    this.hideDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal:
              (MediaQuery.of(context).size.shortestSide >= 600) ? 15 : 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: containerColor,
        // border: Border.all(color: kBlue1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (hideDot ?? false)
              ? const SizedBox.shrink()
              : CustomText(
                  text: "●",
                  color: dotColor,
                  fontSize: 9,
                ),
          (hideDot ?? false) ? const SizedBox.shrink() : const Gap(3),
          Flexible(
            child: Text(
              TextUtils.capitalizeWords(status),
              style: TextStyle(
                color: statusColor,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: 11,
              ),
            ),
            // CustomText(
            //   text: TextUtils.capitalizeWords(status),
            //   color: statusColor,
            //   fontWeight: fontWeight ?? FontWeight.normal,
            //   textOverflow: TextOverflow.ellipsis,
            // ),
          ),
        ],
      ),
    );
  }
}
