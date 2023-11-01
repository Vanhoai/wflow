import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wflow/core/theme/colors.dart';

TextTheme textTheme = TextTheme(
  displaySmall: TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 0.5,
  ),
  displayMedium: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 0.5,
  ),
  displayLarge: TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontSize: 12.sp,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  labelMedium: TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 0.5,
  ),
  labelLarge: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    overflow: TextOverflow.ellipsis,
    letterSpacing: 0.5,
  ),
);

final themeData = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  textTheme: textTheme,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
  ),
  fontFamily: 'SF-Pro-Display',
  dividerTheme: const DividerThemeData(
    color: AppColors.primary,
  ),
);

final themeDataDark = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  textTheme: textTheme,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.primary,
  ),
  fontFamily: 'SF-Pro-Display',
  dividerTheme: const DividerThemeData(
    color: AppColors.primary,
  ),
);
