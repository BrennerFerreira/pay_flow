import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../injectable.dart';
import '../../shared/auth/controller/auth_controller.dart';
import '../../shared/loading_page/loading_page.dart';
import '../../shared/user/models/user.dart';
import 'controllers/boleto_list_controller.dart';
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
  void returnToLoginIfNoUser() {
    if (context.read<AuthController>().user == null) {
      Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthController>().addListener(returnToLoginIfNoUser);
  }

  final User user = getIt<AuthController>().user!;

  final pages = [
    HomeBody(),
    DescriptionBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<HomePageController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<BoletoListController>(),
        )
      ],
      builder: (_, __) {
        return Consumer2<AuthController, BoletoListController>(
          builder: (context, auth, boletoList, __) {
            return auth.loading
                ? LoadingPage()
                : Scaffold(
                    appBar: HomeAppBar.appBar(
                      user: user,
                      onLogOut: () {
                        context.read<HomePageController>().logOut();
                      },
                    ),
                    body: boletoList.isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : pages[Provider.of<HomePageController>(context)
                            .currentPage],
                    bottomNavigationBar: HomeBottomNavBar(),
                  );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    context.read<AuthController>().removeListener(returnToLoginIfNoUser);
    super.dispose();
  }
}
