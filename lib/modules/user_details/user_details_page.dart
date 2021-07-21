import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../app/theme/text_styles.dart';
import '../../shared/auth/controller/auth_controller.dart';
import 'controller/user_details_controller.dart';
import 'widgets/delete_user_dialog.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late FToast _fToast;

  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast.init(context);
  }

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
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16.0,
                          left: 16.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          "Olá, ${context.read<AuthController>().user?.displayName ?? "Usuário"}!",
                          style: AppTextStyles.titleBold,
                        ),
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
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      final provider = Provider.of<AuthController>(
                        context,
                        listen: false,
                      );
                      showDialog(
                        context: context,
                        barrierDismissible: provider.loading,
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: provider,
                            builder: (context, _) {
                              return DeleteUserDialog(
                                toast: _fToast,
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Text("Excluir minha conta"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
