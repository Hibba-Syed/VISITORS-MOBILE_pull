import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../utils/text_utils.dart';


class StatusWidget extends StatelessWidget {
  final String status;
  const StatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 7 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppUtils.getStatusColor(status).withAlpha(24),
        // border: Border.all(color: kBlue1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("●",style: TextStyle(
              color: AppUtils.getStatusColor(status),
              fontSize: 9
          ),
                ),
          const Gap(3),
          Flexible(
            child: Text( status.isNotEmpty ?
              TextUtils.capitalizeWords(status) : "",
              style:  TextStyle(
                color: AppUtils.getStatusColor(status),
                fontWeight:  FontWeight.w500,
                fontSize: AppUtils.isMobile(context) ?  12 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
