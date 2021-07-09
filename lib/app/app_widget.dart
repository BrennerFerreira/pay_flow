import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flavor.dart';
import '../injectable.dart';
import '../shared/auth/controller/auth_controller.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class AppWidget extends StatelessWidget {
  final AppFlavor flavor;

  const AppWidget(this.flavor, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppFlavor>.value(value: flavor),
        ChangeNotifierProvider<AuthController>(
          create: (_) => getIt<AuthController>(),
        ),
      ],
      builder: (_, __) => MaterialApp(
        title: 'Organizador de Boletos',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routes: routes,
      ),
    );
  }
}
