import 'package:boleto_organizer/app/theme/colors.dart';
import 'package:boleto_organizer/app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CopySuccessToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.green,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: AppColors.input,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              "Código de barras copiado para a área de transferência.",
              style: AppTextStyles.input,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
