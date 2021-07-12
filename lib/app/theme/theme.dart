import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    primarySwatch: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(centerTitle: true),
    errorColor: AppColors.delete,
    brightness: Brightness.light,
  );

  static final darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
  );
}
