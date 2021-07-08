import 'package:boleto_organizer/injectable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/routes_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/images.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/auth/controller/auth_controller.dart';
import '../../../shared/widgets/dividers/vertical_divider_widget.dart';
import '../controller/login_controller.dart';

class LoginButton extends StatelessWidget {
  final _controller = getIt<LoginController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: InkWell(
        onTap: () async {
          await _controller.googleSignIn();
          final userIsLoggedIn = context.read<AuthController>().userIsLoggedIn;

          if (userIsLoggedIn) {
            Navigator.pushReplacementNamed(context, HOME_ROUTE);
          }
        },
        child: Container(
          width: size.width - 100,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(
              color: AppColors.stroke,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Image.asset(AppImages.google),
              ),
              VerticalDividerWidget(),
              Expanded(
                flex: 4,
                child: Text(
                  "Entrar com Google",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.buttonSecondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
