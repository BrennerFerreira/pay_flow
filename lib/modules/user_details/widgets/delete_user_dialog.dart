import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/routes_names.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/auth/controller/auth_controller.dart';
import '../../../shared/widgets/label_button/label_button.dart';
import '../../../shared/widgets/toast/toast.dart';

class DeleteUserDialog extends StatelessWidget {
  final FToast toast;

  const DeleteUserDialog({Key? key, required this.toast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        "Excluir conta",
        style: AppTextStyles.titleListTile,
      ),
      content: Provider.of<AuthController>(context).loading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : Text(
              "Você tem certeza que deseja excluir a sua conta? "
              "Esta ação é irreversível!",
              style: AppTextStyles.trailingRegular,
            ),
      actions: Provider.of<AuthController>(context).loading
          ? []
          : [
              LabelButton(
                label: "Cancelar",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              LabelButton(
                label: "Excluir",
                onPressed: () async {
                  final result =
                      await context.read<AuthController>().deleteAccount();

                  if (result) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LOGIN_ROUTE,
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pop();
                    toast.showToast(
                      child: const CustomToast(
                        icon: Icons.error,
                        label: "Falha ao excluir a conta. Tente novamente.",
                        color: AppColors.delete,
                      ),
                    );
                  }
                },
              ),
            ],
    );
  }
}
