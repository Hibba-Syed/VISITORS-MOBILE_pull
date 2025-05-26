import 'package:flutter/material.dart';
import 'package:visitors/resource/styles/styles.dart';
class HeadingWidget extends StatelessWidget {
  final String? heading;
  final TextStyle? style;
  const HeadingWidget({super.key,
    this.heading,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(heading ?? "",style: style ?? AppTextStyles.style20primary600);

  }
}
