import 'package:flutter/material.dart';

Widget fadeTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const curve = Curves.easeInOut;
  return FadeTransition(
    opacity: animation.drive(CurveTween(curve: curve)),
    child: child,
  );
}

