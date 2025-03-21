import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
class CheckInsScreen extends StatelessWidget {
  const CheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Check-In Screen')),
        ],
      ),
    );
  }
}