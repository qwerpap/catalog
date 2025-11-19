import 'package:catalog/core/bloc/app_bloc_providers.dart';
import 'package:catalog/core/navigation/presentation/widgets/app_router.dart';
import 'package:catalog/core/services/logger.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_state.dart';
import 'package:catalog/core/theme/theme.dart';
import 'package:catalog/core/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initApp();
  runApp(const MyApp());
}

Future<void> _initApp() async {
  Logger.enable();
  Logger.info('Application initialized');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlocProvider>>(
      future: AppBlocProviders.providers,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return MultiBlocProvider(
          providers: snapshot.data!,
          child: BlocBuilder<ThemeBloc, ThemeState>(
            buildWhen: (previous, current) =>
                previous.themeMode != current.themeMode,
            builder: (context, themeState) {
              return MaterialApp.router(
                key: ValueKey(themeState.themeMode),
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeState.themeMode == AppThemeMode.dark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                routerConfig: AppRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}
