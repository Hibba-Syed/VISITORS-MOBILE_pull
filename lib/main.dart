import 'package:flutter/material.dart';
import 'package:visitors/eid_card_scanner.dart';
import 'package:visitors/firebase_ml_vision_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iskaan Visitors',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EmiratesIDScanner(),
    );
  }
}
