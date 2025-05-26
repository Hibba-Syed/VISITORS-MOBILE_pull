import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../resource/constants/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: LoadingAnimationWidget.dotsTriangle(
          color: AppColors.primary,
          size: 35,
       ),
      ),
    );
    //   SizedBox(
    //   height: 70,
    //   width: 70,
    //   child: LottieBuilder.asset("assets/loader.json"),
    // );
  }
}
