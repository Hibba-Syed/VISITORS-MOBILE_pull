import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/view/widgets/container_widgets/icon_text_container_widget.dart';

class PhoneEmailInformationCardWidget extends StatelessWidget {
  final String? name;
  final String? email;
  final String? phone;
   const PhoneEmailInformationCardWidget({super.key,
     this.name,
     this.email,
     this.phone,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      decoration:  BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTextContainerWidget(
            textColor: AppColors.darkGrey,
            backgroundColor: AppColors.white,
            icon: CupertinoIcons.person,
            text: name ?? "",
          ),
         const Divider(
            indent:10,
            endIndent: 10,
            color: AppColors.gray,
            thickness: 1,
          ),

          IconTextContainerWidget(
            textColor: AppColors.darkGrey,
            backgroundColor: AppColors.white,
            icon: CupertinoIcons.phone,
            text: phone ?? "",
          ) ,
          const Divider(
            indent: 10,
            endIndent: 10,
            color: AppColors.gray,
            thickness: 1,
          ),
          IconTextContainerWidget(
            textColor: AppColors.darkGrey,
            backgroundColor: AppColors.white,
            icon: Icons.email_outlined,
            text: email ?? "",
          ),
        ],
      ),

    );
  }
}
