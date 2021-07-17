import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../flavor.dart';
import '../injectable.dart';
import '../shared/analytics/controller/analytics_controller.dart';
import '../shared/auth/controller/auth_controller.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class AppWidget extends StatelessWidget {
  final AppFlavor flavor;

  AppWidget(this.flavor, {Key? key}) : super(key: key);

  final _analyticsController = getIt<AnalyticsController>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppFlavor>.value(value: flavor),
        Provider<AnalyticsController>.value(
          value: _analyticsController..appOpen(),
        ),
        ChangeNotifierProvider<AuthController>(
          create: (_) => getIt<AuthController>(),
        ),
      ],
      builder: (context, __) => MaterialApp(
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
        navigatorObservers: [context.read<AnalyticsController>().getObserver()],
      ),
    );
  }
}
