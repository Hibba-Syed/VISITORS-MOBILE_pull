import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import '../bloc/shorebird_update/shorebird_update_cubit.dart';
import '../view/widgets/shorebird_update_dialog.dart';

class ShorebirdUpdaterService {
  final updater = ShorebirdUpdater();
  Future<void> checkForUpdates(BuildContext context) async {
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          useRootNavigator: false,
          builder: (ctx) {
            return BlocProvider(
              create: (_) => UpdateCubit(),
              child: const UpdateDialog(),
            );
          },
        );
      }
    }
  }
}
