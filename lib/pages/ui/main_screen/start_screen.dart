import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/main_screen/start_content.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backround.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StartContent()
      );
  }
}