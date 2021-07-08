import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    primarySwatch: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}
