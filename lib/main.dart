import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/routes/app_pages.dart';
import 'package:visitors/view/Common%20Screens/device_decider_screen.dart' show DeviceDeciderScreen;
import 'package:visitors/view/Common%20Screens/iskaan_visitors_mobile.dart' show IskaanVisitorsMobile;

void main() async {
  runApp( const IskaanVisitorsMobile(),
  );
}
