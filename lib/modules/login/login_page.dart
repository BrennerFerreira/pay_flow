import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/images.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/auth/controller/auth_controller.dart';
import '../../shared/loading_page/loading_page.dart';
import 'widgets/login_button.dart';
import 'widgets/person_image.dart';
import 'widgets/title.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void navigatorListener() {
    if (context.read<AuthController>().user != null) {
      Navigator.pushReplacementNamed(context, HOME_ROUTE);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthController>().addListener(navigatorListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return controller.loading
            ? LoadingPage()
            : Scaffold(
                body: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              AppColors.white,
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
                            LoginButton(),
                            Text(
                              "Ao criar a sua conta, você concorda com a nossa",
                              style: AppTextStyles.captionBody,
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PRIVACY_POLICY_ROUTE,
                                );
                              },
                              child: Text(
                                "Política de Privacidade",
                                style: AppTextStyles.captionBoldBody,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    context.read<AuthController>().removeListener(navigatorListener);
    super.dispose();
  }
}
