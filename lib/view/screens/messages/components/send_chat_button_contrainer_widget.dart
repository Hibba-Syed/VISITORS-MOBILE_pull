import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
class SendChatButtonContainerWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;
  const SendChatButtonContainerWidget({super.key,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: IconButton(
        focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
        onPressed: onPressed,
        icon: Transform.rotate(
          angle: 125,
          child: Icon(Icons.send,
            color: iconColor?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
