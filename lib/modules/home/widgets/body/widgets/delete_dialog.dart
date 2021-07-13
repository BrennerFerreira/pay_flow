import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../../app/theme/colors.dart';
import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/boleto/models/boleto.dart';
import '../../../../../shared/widgets/label_button/label_button.dart';
import '../../../controllers/boleto_list_controller.dart';
import 'delete_error_toast.dart';

class DeleteDialog extends StatelessWidget {
  final Boleto boleto;
  final FToast toast;

  const DeleteDialog({
    Key? key,
    required this.boleto,
    required this.toast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        "Excluir boleto",
        style: AppTextStyles.titleBold,
      ),
      content: Provider.of<BoletoListController>(context).isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : Text(
              "Tem certeza que deseja excluir este boleto?",
              style: AppTextStyles.trailingRegular,
            ),
      actions: Provider.of<BoletoListController>(context).isLoading
          ? []
          : [
              LabelButton(
                label: "Cancelar",
                onPressed: Navigator.of(context).pop,
              ),
              LabelButton(
                label: "Excluir",
                style: AppTextStyles.buttonBoldPrimary,
                onPressed: () async {
                  final result = await Provider.of<BoletoListController>(
                    context,
                    listen: false,
                  ).deleteBoleto(boleto);

                  if (result) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    toast.showToast(
                      child: DeleteErrorToast(),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
    );
  }
}
