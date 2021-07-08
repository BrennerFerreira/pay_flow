import 'package:boleto_organizer/modules/bar_code_scanner/bar_code_scanner_page.dart';
import 'package:boleto_organizer/modules/insert_boleto/insert_boleto_page.dart';
import 'package:flutter/material.dart';

import '../../modules/home/home_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/splash/splash_page.dart';
import 'routes_names.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SPLASH_ROUTE: (_) => SplashPage(),
  LOGIN_ROUTE: (_) => LoginPage(),
  HOME_ROUTE: (_) => HomePage(),
  BAR_CODE_SCANNER_ROUTE: (_) => const BarCodeScannerPage(),
  INSERT_BOLETO_ROUTE: (_) => const InsertBoletoPage(),
};
