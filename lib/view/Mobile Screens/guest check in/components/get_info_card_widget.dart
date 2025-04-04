import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/network_image_widget.dart';

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
              url: profileImageUrl,),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: AppTextStyles.style14Black600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(5),
                  Text(
                    country ?? "",
                    style: AppTextStyles.style12DarkGrey500,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.green),
              padding: const EdgeInsets.all(5),
              child: const Icon(
                Icons.check,
                color: AppColors.white,
              ),
            ),
            const Gap(10),
            InkWell(
              onTap: (){
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context){
                      return CustomAlertDialogBox(
                        isCancelButtonDisable: true,
                        confirmButtonText: 'Delete',
                        confirmButtonColor: AppColors.red,
                        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                        title: 'Delete Visitor Record',
                        contentBuilder: (context,setState){
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.delete,size: 25,color: AppColors.red,),
                               Gap(10),
                              Text('Are you sure you want to delete this visitor record  forever?',style: AppTextStyles.style14Red600),
                            ],
                          );
                        },
                      );
                    }
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: AppColors.red),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  CupertinoIcons.delete,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
