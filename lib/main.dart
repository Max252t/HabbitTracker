import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/theme/theme.dart';
import 'package:habbit_tracker/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: routes,
      initialRoute: '/',
    );
  }
}


