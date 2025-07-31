import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/images.dart';
import '../../../../utils/app_utils.dart';
import '../../../widgets/text field/text_field_widget.dart';
class AddLogActionDesignWidget extends StatelessWidget {
  final TextEditingController noteController;
  const AddLogActionDesignWidget({super.key,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(5),
        SvgPicture.asset(
          AppImages.question,
          height: 35,
          width: 35,
          colorFilter: const ColorFilter.mode(
            AppColors.cyanBlue,
            BlendMode.srcIn,
          ),
        ),
        const Gap(5),
        TextFieldWidget(
          controller: noteController,
          label: AppUtils.languageTranslate('note'),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return AppUtils.languageTranslate(
                  'fieldIsMandatory');
            }
            return null;
          },

        ),
      ],
    );
  }
}
