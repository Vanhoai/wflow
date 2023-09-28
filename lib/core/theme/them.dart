import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';

const TextTheme textTheme = TextTheme(
  displaySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),
  displayMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  displayLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
);

final themeData = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  textTheme: textTheme,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
  ),
  fontFamily: "SF-Pro-Display",
);

final themeDataDark = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  textTheme: textTheme,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.primary,
  ),
  fontFamily: "SF-Pro-Display",
);
