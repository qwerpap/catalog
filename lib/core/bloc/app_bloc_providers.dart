import 'package:catalog/core/di/dependency_injection.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:catalog/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog/catalog_event.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_bloc.dart';
import 'package:catalog/features/catalog/presentation/bloc/filters/filters_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  AppBlocProviders._();

  static Future<List<BlocProvider>> get providers async {
    final themeBloc = await DependencyInjection.themeBloc;
    final catalogBloc = DependencyInjection.catalogBloc;
    final filtersBloc = DependencyInjection.filtersBloc;
    final cartBloc = DependencyInjection.cartBloc;
    
    return [
      BlocProvider<CatalogBloc>(
        create: (context) => catalogBloc..add(const CatalogLoadProducts()),
      ),
      BlocProvider<FiltersBloc>(
        create: (context) => filtersBloc..add(const FiltersLoadInitial()),
      ),
      BlocProvider<CartBloc>(
        create: (context) => cartBloc..add(const CartLoadItems()),
      ),
      BlocProvider<ThemeBloc>(
        create: (context) => themeBloc,
      ),
    ];
  }
}

