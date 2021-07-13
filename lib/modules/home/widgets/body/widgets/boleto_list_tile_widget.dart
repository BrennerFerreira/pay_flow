import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../../../app/theme/text_styles.dart';
import '../../../../../../shared/boleto/models/boleto.dart';
import '../../../../../app/theme/colors.dart';
import '../../../controllers/boleto_list_controller.dart';
import 'boleto_bottom_sheet.dart';
import 'copy_success_toast.dart';

class BoletoListTileWidget extends StatelessWidget {
  final Boleto boleto;

  const BoletoListTileWidget({
    Key? key,
    required this.boleto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moneyMask = MoneyMaskedTextController();
    moneyMask.updateValue(boleto.price);

    final FToast fToast = FToast();
    fToast.init(context);

    return AnimatedCard(
      child: ListTile(
        key: ValueKey<String>(boleto.id),
        isThreeLine: boleto.paid,
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: boleto.barCode));
            fToast.showToast(
              child: CopySuccessToast(),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
          },
          icon: Icon(
            Icons.copy,
            color: boleto.pastDueDate ? AppColors.delete : AppColors.body,
          ),
        ),
        title: Text(
          boleto.name,
          style: boleto.pastDueDate
              ? AppTextStyles.titleListTileError
              : AppTextStyles.titleListTile,
        ),
        subtitle: Text(
          boleto.paid
              ? "Vencimento: ${boleto.dueDateFormatted}\nPago em: ${boleto.paidAtDateFormatted}"
              : "${boleto.pastDueDate ? "Venceu" : "Vence"} em: ${boleto.dueDateFormatted}",
          style: boleto.pastDueDate
              ? AppTextStyles.captionBodyError
              : AppTextStyles.captionBody,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: "R\$ ",
                style: boleto.pastDueDate
                    ? AppTextStyles.trailingRegularError
                    : AppTextStyles.trailingRegular,
                children: [
                  TextSpan(
                    text: moneyMask.text,
                    style: boleto.pastDueDate
                        ? AppTextStyles.trailingBoldError
                        : AppTextStyles.trailingBold,
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          final provider =
              Provider.of<BoletoListController>(context, listen: false);
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ChangeNotifierProvider.value(
                  value: provider,
                  child: Builder(
                    builder: (context) {
                      return BoletoBottomSheet(
                        boleto: boleto,
                        toast: fToast,
                      );
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
