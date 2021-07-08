import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flavor.dart';
import 'routes/routes.dart';

class AppWidget extends StatelessWidget {
  final AppFlavor flavor;

  const AppWidget(this.flavor, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider<AppFlavor>.value(value: flavor),
        ],
      ),
      routes: routes,
    );
  }
}
