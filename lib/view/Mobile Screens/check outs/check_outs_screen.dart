import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
class CheckOutsScreen extends StatelessWidget {
  const CheckOutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('CheckOuts Screen')),
        ],
      ),
    );
  }
}
