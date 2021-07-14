import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        title: flavor == AppFlavor.PROD
            ? 'Pay Flow'
            : flavor == AppFlavor.PREVIEW
                ? 'Pay Flow - Preview'
                : 'Pay Flow - Dev',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routes: routes,
      ),
    );
  }
}
