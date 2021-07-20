import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../injectable.dart';
import '../../shared/analytics/controller/analytics_controller.dart';
import '../../shared/auth/controller/auth_controller.dart';
import '../../shared/loading_page/loading_page.dart';
import '../../shared/widgets/toast/toast.dart';
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
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    context.read<AnalyticsController>().newPageAccessed('home');
    fToast = FToast();
    fToast.init(context);
  }

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
                      user: Provider.of<AuthController>(
                        context,
                        listen: true,
                      ).user,
                      onUserDetailsTap: () {
                        Navigator.of(context).pushNamed(USER_DETAILS_ROUTE);
                      },
                      onLogOut: () async {
                        final result =
                            await context.read<HomePageController>().logOut();

                        if (result) {
                          context.read<AnalyticsController>().userLoggedOut();

                          Navigator.of(context)
                              .pushReplacementNamed(LOGIN_ROUTE);
                        } else {
                          fToast.showToast(
                            child: const CustomToast(
                              color: AppColors.delete,
                              icon: Icons.error,
                              label:
                                  "Erro ao terminar a sessão. Por favor, tente novamente.",
                            ),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: const Duration(seconds: 2),
                          );
                        }
                      },
                    ),
                    body: auth.userIsLoggedIn
                        ? boletoList.isLoading
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : pages[Provider.of<HomePageController>(context)
                                .currentPage]
                        : Container(),
                    bottomNavigationBar: const HomeBottomNavBar(),
                  );
          },
        );
      },
    );
  }
}
