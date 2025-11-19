import 'package:catalog/core/navigation/data/constants/navigation_paths.dart';
import 'package:catalog/core/navigation/presentation/transitions/slide_transition.dart';
import 'package:catalog/core/navigation/presentation/widgets/main_scaffold.dart';
import 'package:catalog/features/cart/presentation/view/cart_screen.dart';
import 'package:catalog/features/catalog/data/models/product_model.dart';
import 'package:catalog/features/catalog/domain/entities/product.dart';
import 'package:catalog/features/catalog/presentation/view/catalog_screen.dart';
import 'package:catalog/features/catalog/presentation/view/filters_screen.dart';
import 'package:catalog/features/catalog/presentation/view/product_details_screen.dart';
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
      GoRoute(
        path: NavigationPaths.productDetails,
        pageBuilder: (context, state) {
          final productJson = state.extra as Map<String, dynamic>?;
          if (productJson != null) {
            final productModel = ProductModel.fromJson(productJson);
            final product = Product(
              id: productModel.id,
              title: productModel.title,
              price: productModel.price,
              description: productModel.description,
              category: productModel.category,
              image: productModel.image,
              rating: productModel.rating,
            );
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: ProductDetailsScreen(product: product),
              transitionsBuilder: slideTransitionBuilder,
            );
          }
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const Scaffold(
              body: Center(child: Text('Product not found')),
            ),
            transitionsBuilder: slideTransitionBuilder,
          );
        },
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
