import 'package:flutter/material.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  const EmptyWidget({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(
        text?? AppUtils.languageTranslate('noDataAvailable'),
        style: AppTextStyles.style14darkGrey400,
      ),
    );
  }
}
