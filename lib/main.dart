import 'package:catalog/core/navigation/presentation/widgets/app_router.dart';
import 'package:catalog/core/services/logger.dart';
import 'package:catalog/core/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  _initApp();
  runApp(const MyApp());
}

void _initApp() {
  Logger.enable();
  Logger.info('Application initialized');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
