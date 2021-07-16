import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';

class ErrorToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.delete,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.error),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              "Erro ao salvar o boleto. Por favor, tente novamente.",
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
