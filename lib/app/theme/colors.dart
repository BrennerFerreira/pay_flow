import 'package:flutter/material.dart';

class AppColors {
  static final primary = Color(0xFFFF941A);
  static final title = Color(0xFF585666);
  static final delete = Color(0xFFE83F5B);
  static final body = Color(0xFF706E7A);
  static final stroke = Color(0xFFE3E3E6);
  static final background = Color(0xFFFFFFFF);
  static final black = Color(0xFF000000);
  static final input = Color(0xFFB1B0B8);

  static const MaterialColor primaryColor = MaterialColor(
    _primaryColorPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFF2E4),
      100: Color(0xFFFFDFBA),
      200: Color(0xFFFFCA8D),
      300: Color(0xFFFFB45F),
      400: Color(0xFFFFA43C),
      500: Color(_primaryColorPrimaryValue),
      600: Color(0xFFFF8C17),
      700: Color(0xFFFF8113),
      800: Color(0xFFFF770F),
      900: Color(0xFFFF6508),
    },
  );
  static const int _primaryColorPrimaryValue = 0xFFFF941A;

  static const MaterialColor primaryColorAccent =
      MaterialColor(_primaryColorAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_primaryColorAccentValue),
    400: Color(0xFFFFD5C1),
    700: Color(0xFFFFC4A7),
  });
  static const int _primaryColorAccentValue = 0xFFFFF8F4;
}
