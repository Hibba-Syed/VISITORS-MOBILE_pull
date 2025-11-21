import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart' hide UpdateStatus;

import '../../bloc/shorebird_update/shorebird_update_cubit.dart';
import '../../resource/constants/app_colors.dart';
import '../../resource/styles/styles.dart';
import '../../utils/app_utils.dart';
import 'button/custom_button.dart';
import 'loader/loader_widget.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateCubit>();

    return BlocConsumer<UpdateCubit, ShorebirdUpdateStatus>(
      listener: (context, state) {
        if (state == ShorebirdUpdateStatus.updated) {
          Restart.restartApp();
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.restart_alt_rounded,
                    color: AppColors.primary,
                    size: 50,
                  ),
                  const Gap(16.0),

                  // Localized text
                  Text(
                    state == ShorebirdUpdateStatus.updating
                        ? AppUtils.languageTranslate('update_restart_title')
                        : AppUtils.languageTranslate(
                            'update_restart_description'),
                    style: AppTextStyles.style16Black500,
                    textAlign: TextAlign.center,
                  ),

                  const Gap(20.0),

                  if (state == ShorebirdUpdateStatus.updating)
                    const LoaderWidget()
                  else
                    Flexible(
                      child: CustomButton(
                        text:
                            AppUtils.languageTranslate('update_restart_button'),
                        invert: true,
                        onPressed: () async {
                          cubit.startUpdate();
                          try {
                            await ShorebirdUpdater().update();
                            cubit.finishUpdate();
                          } catch (e) {
                            cubit.setError();

                            Fluttertoast.showToast(
                              msg: "${AppUtils.languageTranslate(
                                'update_error',
                              )} $e",
                            );

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
