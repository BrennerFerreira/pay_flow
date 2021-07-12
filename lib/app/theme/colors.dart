import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppColors {
  static const primary = Color(0xFFFF941A);
  static const delete = Color(0xFFE83F5B);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const green = Color(0xFF499F68);
  static const _lightTitle = Color(0xFF585666);
  static const _lightBody = Color(0xFF706E7A);
  static const _lightStroke = Color(0xFFE3E3E6);
  static const _lightBackground = Color(0xFFFFFFFF);
  static const _lightInput = Color(0xFFB1B0B8);
  static const _darkTitle = Color(0xFFE6E8E6);
  static const _darkBody = Color(0xFFE3E3E6);
  static const _darkStroke = Color(0xFF706E7A);
  static const _darkBackground = Color(0xFF393E41);
  static const _darkInput = Color(0xFFFFFFFF);

  static final bool _isDarkMode =
      (SchedulerBinding.instance?.window.platformBrightness ??
              Brightness.light) ==
          Brightness.dark;

  static final Color title = _isDarkMode ? _darkTitle : _lightTitle;
  static final Color body = _isDarkMode ? _darkBody : _lightBody;
  static final Color stroke = _isDarkMode ? _darkStroke : _lightStroke;
  static final Color background =
      _isDarkMode ? _darkBackground : _lightBackground;
  static final Color input = _isDarkMode ? _darkInput : _lightInput;

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
