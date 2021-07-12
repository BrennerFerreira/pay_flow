import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../../../../../app/theme/text_styles.dart';
import '../../../../../../shared/boleto/models/boleto.dart';

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
    return AnimatedCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          boleto.name,
          style: AppTextStyles.titleListTile,
        ),
        subtitle: Text(
          "Vence em: ${boleto.dateFormatted}",
          style: AppTextStyles.captionBody,
        ),
        trailing: Text.rich(
          TextSpan(
            text: "R\$ ",
            style: AppTextStyles.trailingRegular,
            children: [
              TextSpan(
                text: moneyMask.text,
                style: AppTextStyles.trailingBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
