import 'package:boleto_organizer/app/theme/text_styles.dart';
import 'package:boleto_organizer/modules/user_details/controller/user_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              ],
            ),
          );
        },
      ),
    );
  }
}
