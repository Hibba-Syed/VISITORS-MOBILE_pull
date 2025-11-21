import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../../utils/app_utils.dart';

class UpgradeAlertWidget extends StatelessWidget {
  final bool isEnabled;
  final Widget? child;
  const UpgradeAlertWidget({
    super.key,
    this.child,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isEnabled) {
      return UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
        upgrader: Upgrader(
          durationUntilAlertAgain: const Duration(seconds: 0),
          messages: UpgradeAlertMessages(),
        ),
        showIgnore: false,
        showLater: false,
        // shouldPopScope: () {
        //   return false;
        // },
        child: child,
      );
    }
    return child ?? const SizedBox.shrink();
  }
}

class UpgradeAlertMessages extends UpgraderMessages {
  @override
  String get title => AppUtils.languageTranslate('update_title');

  @override
  String get body => AppUtils.languageTranslate('update_body');

  @override
  String get prompt => AppUtils.languageTranslate('update_prompt');

// If needed later:
// @override
// String get buttonTitleIgnore => AppUtils.languageTranslate('ignore_button');
// @override
// String get buttonTitleUpdate => AppUtils.languageTranslate('update_button');
// @override
// String get buttonTitleLater => AppUtils.languageTranslate('later_button');
}
