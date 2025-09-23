import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../resource/constants/app_colors.dart';
import '../../resource/constants/images.dart';
import '../../utils/app_utils.dart';
import 'text field/text_field_widget.dart';

class AddLogCompleteActionDesignWidget extends StatelessWidget {
  final TextEditingController noteController;
  final TextEditingController? nameController;
  final TextEditingController? idController;
  final TextEditingController? newCardController;
  final TextEditingController? oldCardController;
  final bool isAccessDevice;
  final String? requesterType;

  const AddLogCompleteActionDesignWidget({
    super.key,
    required this.noteController,
    this.isAccessDevice = false,
    this.newCardController,
    this.oldCardController,
    this.idController,
    this.nameController,
    this.requesterType,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(5),
        SvgPicture.asset(
          AppImages.question,
          height: 35,
          width: 35,
          colorFilter: ColorFilter.mode(
            isAccessDevice ? AppColors.green : AppColors.cyanBlue,
            BlendMode.srcIn,
          ),
        ),
        if (isAccessDevice) ...[
          const Gap(5),
          TextFieldWidget(
            label: AppUtils.languageTranslate('requesterName'),
            controller: nameController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return AppUtils.languageTranslate('fieldIsMandatory');
              }
              return null;
            },
          ),
          const Gap(5),
          TextFieldWidget(
            label: '${AppUtils.languageTranslate('idNumber')} *',
            controller: idController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return AppUtils.languageTranslate('fieldIsMandatory');
              }
              return null;
            },
          ),
          const Gap(5),
          TextFieldWidget(
            label: AppUtils.languageTranslate('newCardNumber'),
            controller: newCardController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return AppUtils.languageTranslate('fieldIsMandatory');
              }
              return null;
            },
          ),
          if (requesterType?.toLowerCase() == "replacement") ...[
            const Gap(5),
            TextFieldWidget(
              label: '${AppUtils.languageTranslate('oldCardNumber')} *',
              controller: oldCardController,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return AppUtils.languageTranslate('fieldIsMandatory');
                }
                return null;
              },
            ),
          ],
        ],
        const Gap(5),
        TextFieldWidget(
          controller: noteController,
          label: isAccessDevice
              ? AppUtils.languageTranslate('servicesNote')
              : AppUtils.languageTranslate('note'),
          maxLength: 1000,
          validator: (value) {
            if (isAccessDevice) return null;
            if (value?.trim().isEmpty ?? true) {
              return AppUtils.languageTranslate('fieldIsMandatory');
            }
            return null;
          },
        ),
      ],
    );
  }
}
