import 'package:flutter/material.dart';

import '../../app/theme/images.dart';
import 'controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  final _controller = SplashController();
  @override
  Widget build(BuildContext context) {
    _controller.checkLoggedUser(context);
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
