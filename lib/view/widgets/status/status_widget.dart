import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import '../../../utils/text_utils.dart';

class StatusWidget extends StatelessWidget {
  final String status;
  final Color dotColor;
  final Color statusColor;
  final Color backgroundColor;
  const StatusWidget({
    super.key,
    required this.status,
    required this.dotColor,
    required this.statusColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 7 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
        // border: Border.all(color: kBlue1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("●",style: TextStyle(
              color: dotColor,
              fontSize: 9
          ),
                ),
          const Gap(3),
          Flexible(
            child: Text(
              TextUtils.capitalizeWords(status),
              style: TextStyle(
                color: statusColor,
                fontWeight:  FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
