import 'package:flutter/material.dart';

import '../../../../../app/theme/text_styles.dart';
import '../../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../widgets/boleto_list_widget.dart';

class DescriptionBody extends StatelessWidget {
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
              "Boletos Pagos",
              style: AppTextStyles.titleBold,
            ),
          ),
          HorizontalDividerWidget(),
          const Expanded(
            child: BoletoListWidget(showPaidBoletos: true),
          ),
        ],
      ),
    );
  }
}
