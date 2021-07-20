import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../injectable.dart';
import '../../modules/home/home_page.dart';
import '../../modules/insert_boleto/controller/insert_boleto_controller.dart';
import '../../modules/insert_boleto/insert_boleto_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/privacy_policy/privacy_policy_page.dart';
import '../../modules/splash/splash_page.dart';
import '../../modules/user_details/user_details_page.dart';
import 'routes_names.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SPLASH_ROUTE: (_) => SplashPage(),
  LOGIN_ROUTE: (_) => LoginPage(),
  PRIVACY_POLICY_ROUTE: (_) => PrivacyPolicyPage(),
  HOME_ROUTE: (_) => HomePage(),
  USER_DETAILS_ROUTE: (_) => UserDetailsPage(),
  INSERT_BOLETO_ROUTE: (context) =>
      ChangeNotifierProvider<InsertBoletoController>(
        create: (_) => getIt<InsertBoletoController>(),
        builder: (context, _) => InsertBoletoPage(
          barCode: ModalRoute.of(context)?.settings.arguments as String?,
        ),
      ),
};
