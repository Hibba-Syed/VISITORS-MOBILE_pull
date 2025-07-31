import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../utils/app_utils.dart';
import '../../../widgets/text field/text_field_widget.dart';
class CompleteActionDesignWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController noteController;
  final TextEditingController? newCardController;
  final bool isAccessDevice;
  const  CompleteActionDesignWidget({super.key,
    required this.nameController,
    required this.idController,
    required this.noteController,
     this.newCardController,
    this.isAccessDevice = false,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        const Gap(5),
        SvgPicture.asset(
          AppImages.question,
          height: 35,
          width: 35,
          colorFilter: const ColorFilter.mode(
            AppColors.green,
            BlendMode.srcIn,
          ),
        ),
        const Gap(5),
        TextFieldWidget(
          label: AppUtils.languageTranslate(
              'requesterName'),
          controller: nameController,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return AppUtils.languageTranslate(
                  'fieldIsMandatory');
            }
            return null;
          },
        ),
        const Gap(5),
        TextFieldWidget(
          label: AppUtils.languageTranslate(
              'idNumber'),
          controller: idController,
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return AppUtils.languageTranslate(
                  'fieldIsMandatory');
            }
            return null;
          },
        ),
        if(isAccessDevice) ...[
          const Gap(5),
          TextFieldWidget(
            label: AppUtils.languageTranslate(
                'newCardNumber'),
            controller: newCardController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return AppUtils.languageTranslate(
                    'fieldIsMandatory');
              }
              return null;
            },
          ),
        ],
        const Gap(5),
        TextFieldWidget(
          controller: noteController,
          label: AppUtils.languageTranslate(
              'servicesNote'),
        ),
      ],
    );
  }
}
