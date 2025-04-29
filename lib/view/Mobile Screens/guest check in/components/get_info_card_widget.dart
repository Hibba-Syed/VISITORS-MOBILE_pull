import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/small_button.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';

import '../../../../resource/constants/app_constants.dart';

class GetInfoCardWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? name;
  final String? country;
  final VoidCallback? deleteOnPressed;
  const GetInfoCardWidget(
      {super.key,
      this.profileImageUrl,
      this.name,
      this.country,
      this.deleteOnPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageWidget(
              height: 50,
              width: 50,
              url: profileImageUrl,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: AppConstants.isTablet(context) ? AppTextStyles.style15Black600 : AppTextStyles.style14Black600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(5),
                  Text(
                    country ?? "",
                    style: AppConstants.isTablet(context) ?  AppTextStyles.style13DarkGrey600 : AppTextStyles.style12DarkGrey600,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SmallButton(
              width: AppConstants.isTablet(context) ? 60 : 40,
              height: AppConstants.isTablet(context) ? 60 : 40,
              icon: Icons.check,
              backgroundColor: AppColors.green,
              onPressed: () {},
            ),
            const Gap(10),
            SmallButton(
              width: AppConstants.isTablet(context) ? 60 : 40,
              height: AppConstants.isTablet(context) ? 60 : 40,
              icon: CupertinoIcons.delete,
              backgroundColor: AppColors.red,
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CustomAlertDialogBox(
                        isCancelButtonDisable: true,
                        confirmButtonText: 'Delete',
                        confirmButtonColor: AppColors.red,
                        insetPadding:
                        AppConstants.isTablet( context) ?
                      EdgeInsets.symmetric(horizontal: 40) :
                        EdgeInsets.all(20),
                        title: 'Delete Visitor Record',
                        contentBuilder: (context, setState) {
                          return  Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(
                                  CupertinoIcons.delete,
                                  color: AppColors.red,
                                  size: AppConstants.isTablet(context) ? 42 : 22,
                                ),
                                Gap(15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                      'Are you sure you want to delete this visitor record  forever?',
                                      style: AppTextStyles.style15Red600),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ],
    );
  }
}
