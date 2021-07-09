import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../injectable.dart';
import '../../shared/auth/controller/auth_controller.dart';
import '../../shared/user/models/user.dart';
import 'controllers/home_controller.dart';
import 'widgets/body/description_body/description_body.dart';
import 'widgets/body/home_body/home_body.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthController>().addListener(() {
      if (context.read<AuthController>().user == null) {
        Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
      }
    });
  }

  final User user = getIt<AuthController>().user!;

  final pages = [
    HomeBody(),
    DescriptionBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageController(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: HomeAppBar.appBar(
                user: user,
                onLogOut: () {
                  context.read<HomePageController>().logOut(context);
                }),
            body: pages[context.watch<HomePageController>().currentPage],
            bottomNavigationBar: HomeBottomNavBar(
              onScannerPressed: () async {
                await Navigator.pushNamed(
                  context,
                  BAR_CODE_SCANNER_ROUTE,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
