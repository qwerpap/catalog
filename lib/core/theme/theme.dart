import 'package:flutter/material.dart';
import 'app_colors.dart';

final lightTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    surface: AppColors.lightSurfaceColor,
    onSurface: AppColors.blackColor,
  ),
  scaffoldBackgroundColor: AppColors.lightBackgroundColor,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.blackColor),
    titleTextStyle: const TextStyle(
      color: AppColors.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.inactiveNavColor,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
);

final darkTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryColor,
    surface: AppColors.surfaceColor,
    onSurface: AppColors.whiteColor,
  ),
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.whiteColor),
    titleTextStyle: const TextStyle(
      color: AppColors.whiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.inactiveNavColor,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
);
