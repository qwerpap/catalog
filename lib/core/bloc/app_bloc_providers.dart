import 'package:catalog/core/di/dependency_injection.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  AppBlocProviders._();

  static Future<List<BlocProvider>> get providers async {
    final themeBloc = await DependencyInjection.themeBloc;
    return [
      BlocProvider<CatalogBloc>(
        create: (context) => DependencyInjection.catalogBloc
          ..add(const CatalogLoadProducts()),
      ),
      BlocProvider<ThemeBloc>(
        create: (context) => themeBloc,
      ),
    ];
  }
}

