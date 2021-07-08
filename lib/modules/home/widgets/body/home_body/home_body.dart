import 'package:flutter/material.dart';

import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/boleto/models/boleto.dart';
import '../../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../controllers/boleto_list_controller.dart';
import '../widgets/boleto_list_widget.dart';

class HomeBody extends StatelessWidget {
  final _listController = BoletoListController();

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
                ValueListenableBuilder<List<Boleto>>(
                    valueListenable: _listController.boletosNotifier,
                    builder: (_, boletos, __) {
                      return Text(
                        "${boletos.length} a pagar",
                        style: AppTextStyles.trailingRegular,
                      );
                    })
              ],
            ),
          ),
          HorizontalDividerWidget(),
          Expanded(
            child: BoletoListWidget(controller: _listController),
          ),
        ],
      ),
    );
  }
}
