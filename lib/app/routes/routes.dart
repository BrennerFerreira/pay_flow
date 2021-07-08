import 'package:flutter/material.dart';

import '../../modules/home/home_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/splash/splash_page.dart';
import 'routes_names.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SPLASH_ROUTE: (_) => SplashPage(),
  LOGIN_ROUTE: (_) => LoginPage(),
  HOME_ROUTE: (_) => HomePage(),
};
