import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../app/theme/colors.dart';
import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/boleto/models/boleto.dart';
import '../../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../controllers/boleto_list_controller.dart';
import 'delete_dialog.dart';
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
                    text: boleto.paid ? "foi pago em " : "foi pago?",
                    style: AppTextStyles.titleRegular,
                  ),
                  if (boleto.paid)
                    TextSpan(
                      text: boleto.paidAtDateFormatted,
                      style: AppTextStyles.titleBold,
                    ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            if (!boleto.paid)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Provider.of<BoletoListController>(context).isLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: StyledLabelButton(
                                label: "Ainda não",
                                onPressed: Navigator.of(context).pop,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: StyledLabelButton(
                                label: "Sim",
                                onPressed: () async {
                                  await Provider.of<BoletoListController>(
                                    context,
                                    listen: false,
                                  ).updateBoletoPaid(boleto);
                                  Navigator.of(context).pop();
                                },
                                isPrimary: true,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            if (boleto.paid) const SizedBox(height: 24),
            HorizontalDividerWidget(),
            InkWell(
              onTap: Provider.of<BoletoListController>(context).isLoading
                  ? null
                  : () {
                      final provider = Provider.of<BoletoListController>(
                        context,
                        listen: false,
                      );

                      showDialog(
                        context: context,
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: provider,
                            child: Builder(
                              builder: (context) {
                                return DeleteDialog(
                                  boleto: boleto,
                                  toast: toast,
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
