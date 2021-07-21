import 'package:boleto_organizer/modules/user_details/controller/user_details_controller.dart';
import 'package:boleto_organizer/shared/analytics/controller/analytics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/images.dart';
import '../../shared/auth/controller/auth_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      final currentUser = context.read<AuthController>().getCurrentUser();

      if (currentUser == null) {
        Navigator.of(context).pushReplacementNamed(LOGIN_ROUTE);
        return;
      }

      context.read<AnalyticsController>().setUserId(currentUser.id);

      if (context.read<UserDetailsController>().useLocalAuth) {
        Navigator.of(context)
            .pushReplacementNamed(LOCAL_AUTH_ROUTE, arguments: "splash page");
      } else {
        Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppImages.union),
            Image.asset(AppImages.logoFull),
          ],
        ),
      ),
    );
  }
}
