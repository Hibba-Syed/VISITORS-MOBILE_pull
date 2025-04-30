import 'package:flutter/material.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveLayoutWidget({
    required this.mobile,
    required this.tablet,
    super.key,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600 ? tablet : mobile;
  }
}