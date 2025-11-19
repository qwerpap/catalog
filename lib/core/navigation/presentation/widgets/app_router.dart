import 'package:catalog/core/navigation/data/constants/navigation_paths.dart';
import 'package:catalog/core/navigation/presentation/widgets/main_scaffold.dart';
import 'package:catalog/features/cart/view/cart_screen.dart';
import 'package:catalog/features/catalog/presentation/view/catalog_screen.dart';
import 'package:catalog/features/catalog/presentation/view/filters_screen.dart';
import 'package:catalog/features/profile/presentation/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: NavigationPaths.catalog,
    routes: [
      GoRoute(
        path: NavigationPaths.filters,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const FiltersScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NavigationPaths.catalog,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const CatalogScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NavigationPaths.cart,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const CartScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: NavigationPaths.profile,
                pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
