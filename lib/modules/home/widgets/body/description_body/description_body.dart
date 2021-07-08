import 'package:flutter/material.dart';

import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../controllers/boleto_list_controller.dart';
import '../widgets/boleto_list_widget.dart';

class DescriptionBody extends StatelessWidget {
  final _listController = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              "Meu extrato",
              style: AppTextStyles.titleBold,
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
