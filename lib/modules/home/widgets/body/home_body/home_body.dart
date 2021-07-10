import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../controllers/boleto_list_controller.dart';
import '../widgets/boleto_list_widget.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meus boletos",
                  style: AppTextStyles.titleBold,
                ),
                Consumer<BoletoListController>(
                  builder: (_, boletoList, __) {
                    return Text(
                      "${boletoList.boletos.length} a pagar",
                      style: AppTextStyles.trailingRegular,
                    );
                  },
                )
              ],
            ),
          ),
          HorizontalDividerWidget(),
          Expanded(
            child: BoletoListWidget(),
          ),
        ],
      ),
    );
  }
}
