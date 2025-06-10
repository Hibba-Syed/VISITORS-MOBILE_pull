import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';
import '../../../../utils/app_utils.dart';
import 'get_info_card_widget.dart';

class SelectVisitorNumberWidget extends StatelessWidget {
  final int? count;
  final String? name;
  final String? country;
  final String? profileImageUrl;


  const SelectVisitorNumberWidget({
    super.key,
     this.count,
    this.name,
    this.country,
    this.profileImageUrl,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: AppTextStyles.style36Blue500,
        ),
        Text(
          'Visitor records found for this number',
          style:  AppUtils.isMobile(context) ? AppTextStyles.style14Black600 :AppTextStyles.style15Black600,
        ),
        const Divider(
          color: AppColors.lightGrey,
        ),
        const Gap(5),
        ConstrainedBox(
          constraints: const BoxConstraints(
              maxHeight: 250),
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: 2,
            itemBuilder: (context, index) {
              return  GetInfoCardWidget(
                name: name ?? '',
                country: country ?? '',
                profileImageUrl: profileImageUrl ?? '',
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: AppColors.lightGrey,
              );
            },
          ),
        ),
      ],
    );
  }
}