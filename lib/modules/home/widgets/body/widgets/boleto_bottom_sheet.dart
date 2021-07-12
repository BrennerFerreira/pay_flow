import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../app/theme/colors.dart';
import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/boleto/models/boleto.dart';
import '../../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../../../shared/widgets/label_button/label_button.dart';
import '../../../controllers/boleto_list_controller.dart';
import 'delete_error_toast.dart';
import 'styled_label_button.dart';

class BoletoBottomSheet extends StatelessWidget {
  final Boleto boleto;
  final FToast toast;

  const BoletoBottomSheet({
    Key? key,
    required this.boleto,
    required this.toast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyMask = MoneyMaskedTextController();
    moneyMask.updateValue(boleto.price);
    return BottomSheet(
      onClosing: Navigator.of(context).pop,
      builder: (context) => Container(
        color: AppColors.background,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height * 0.025,
          right: MediaQuery.of(context).size.height * 0.025,
          bottom: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Icon(
                Icons.drag_handle_rounded,
                color: AppColors.body,
              ),
            ),
            Text.rich(
              TextSpan(
                text: "O boleto ",
                style: AppTextStyles.titleRegular,
                children: [
                  TextSpan(
                    text: "${boleto.name}\n",
                    style: AppTextStyles.titleBold,
                  ),
                  TextSpan(
                    text: "no valor de R\$ ",
                    style: AppTextStyles.titleRegular,
                  ),
                  TextSpan(
                    text: "${moneyMask.text}\n",
                    style: AppTextStyles.titleBold,
                  ),
                  TextSpan(
                    text: "foi pago?",
                    style: AppTextStyles.titleRegular,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: StyledLabelButton(
                        label: "Ainda não",
                        onPressed: Navigator.of(context).pop,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: StyledLabelButton(
                        label: "Sim",
                        onPressed: () {},
                        isPrimary: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HorizontalDividerWidget(),
            InkWell(
              onTap: () {
                final provider =
                    Provider.of<BoletoListController>(context, listen: false);
                showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider.value(
                      value: provider,
                      child: Builder(
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.background,
                            title: Text(
                              "Excluir boleto",
                              style: AppTextStyles.titleBold,
                            ),
                            content: Provider.of<BoletoListController>(context)
                                    .isLoading
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  )
                                : Text(
                                    "Tem certeza que deseja excluir este boleto?",
                                    style: AppTextStyles.trailingRegular,
                                  ),
                            actions: Provider.of<BoletoListController>(context)
                                    .isLoading
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
                                        final result = await Provider.of<
                                            BoletoListController>(
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
                                            toastDuration:
                                                const Duration(seconds: 2),
                                          );
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                height: 52.0,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.trash,
                      color: AppColors.delete,
                      size: 15,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Excluir boleto",
                      style: AppTextStyles.delete,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
