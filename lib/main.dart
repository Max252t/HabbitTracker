import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit_tracker/core/app_bloc_observer.dart';
import 'package:habbit_tracker/core/app_logger.dart';
import 'package:habbit_tracker/pages/ui/theme/theme.dart';
import 'package:habbit_tracker/router/router.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  appLogger.i('App starting...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appLogger.i('Building MyApp');
    return MaterialApp(theme: theme, routes: routes, initialRoute: '/');
  }
}
