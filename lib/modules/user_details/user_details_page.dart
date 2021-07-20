import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/theme/text_styles.dart';
import 'controller/user_details_controller.dart';

class UserDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do usuário"),
      ),
      body: Consumer<UserDetailsController>(
        builder: (context, controller, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView(
              children: [
                SwitchListTile.adaptive(
                  title: Text(
                    "Tema escuro",
                    style: AppTextStyles.titleListTile,
                  ),
                  value: controller.isDarkTheme,
                  onChanged: (value) {
                    controller.isDarkTheme = value;
                  },
                ),
                SwitchListTile.adaptive(
                  title: Text(
                    "Usar biometria ao abrir o app",
                    style: AppTextStyles.titleListTile,
                  ),
                  subtitle: Text(
                    "Escolha caso deseje proteger o app para somente abrir após "
                    "a autenticação biométrica.",
                    style: AppTextStyles.captionBody,
                  ),
                  value: controller.useLocalAuth,
                  onChanged: (value) {
                    controller.setUseLocalAuth(newValue: value);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
