import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool isUnderline;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  const CustomText({
    super.key,
    required this.text,
    this.color ,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 13,
    this.textAlign,
    this.maxLines,
    this.isUnderline = false,
    this.textOverflow,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
         color: color ?? const Color(0xff575757),
        fontWeight: fontWeight,
        fontStyle: fontStyle, 
        fontSize: fontSize,
        overflow:
            textOverflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
        decoration: isUnderline ? TextDecoration.underline : null,
        decorationColor: color ?? const Color(0xff575757),
      ),
      textAlign: textAlign,
      maxLines: maxLines,

    );
  }
}
