import 'package:cuidame/app/configs/theme/app_color_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static get themeData => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.secondary,
          surface: AppColors.light,
        ),

        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: AppColors.lightGray,

        fontFamily: 'SFProDisplay',

        // TextTheme
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.black),
          displayMedium: TextStyle(color: AppColors.black),
          displaySmall: TextStyle(color: AppColors.black),
          headlineLarge: TextStyle(color: AppColors.black),
          headlineMedium: TextStyle(color: AppColors.black),
          headlineSmall: TextStyle(color: AppColors.black),
          titleLarge: TextStyle(color: AppColors.black),
          titleMedium: TextStyle(fontWeight: FontWeight.w600, color: AppColors.black),
          titleSmall: TextStyle(color: AppColors.black),
          labelLarge: TextStyle(color: AppColors.black),
          labelMedium: TextStyle(fontWeight: FontWeight.w600, color: AppColors.black),
          labelSmall: TextStyle(color: AppColors.black),
          bodyLarge: TextStyle(color: AppColors.black),
          bodyMedium: TextStyle(color: AppColors.black),
          bodySmall: TextStyle(color: AppColors.black),
        ),
      );
}
