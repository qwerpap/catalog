import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  static Future<T?> pushWithSlide<T extends Object?>(
    BuildContext context,
    String path, {
    Object? extra,
  }) {
    return context.push<T>(
      path,
      extra: extra,
    );
  }

  static void goWithFade(
    BuildContext context,
    String path, {
    Object? extra,
  }) {
    context.go(
      path,
      extra: extra,
    );
  }
}
