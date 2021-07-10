import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modules/bar_code_scanner/bar_code_scanner_page.dart';
import '../../modules/bar_code_scanner/controller/bar_code_scanner_controller.dart';
import '../../modules/home/home_page.dart';
import '../../modules/insert_boleto/insert_boleto_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/splash/splash_page.dart';
import 'routes_names.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SPLASH_ROUTE: (_) => SplashPage(),
  LOGIN_ROUTE: (_) => LoginPage(),
  HOME_ROUTE: (_) => HomePage(),
  BAR_CODE_SCANNER_ROUTE: (context) => ChangeNotifierProvider(
        create: (_) => BarCodeScannerController(),
        builder: (_, __) => const BarCodeScannerPage(),
      ),
  INSERT_BOLETO_ROUTE: (context) => InsertBoletoPage(
        barCode: ModalRoute.of(context)?.settings.arguments as String?,
      ),
};
