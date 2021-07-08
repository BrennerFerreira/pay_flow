import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/images.dart';
import 'controller/login_controller.dart';
import 'widgets/login_button.dart';
import 'widgets/person_image.dart';
import 'widgets/title.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.background,
                    AppColors.primary,
                  ],
                  center: Alignment(0, 2),
                  radius: 1.5,
                ),
              ),
              height: size.height * 0.36,
              width: size.width,
            ),
            PersonImage(),
            Positioned(
              top: size.height * 0.1 + 398,
              right: 0,
              left: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppImages.logomini),
                  LoginTitle(),
                  LoginButton(
                    onTap: () async => _controller.googleSignIn(context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
