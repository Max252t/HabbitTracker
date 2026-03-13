import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/main_screen/start_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartScreen(),
    );
  }
}
