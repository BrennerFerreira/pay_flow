import 'package:flutter/material.dart';

import '../../../app/theme/text_styles.dart';

class LoginTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 50.0,
      ),
      child: Text(
        "Organize seus boletos em um só lugar",
        style: AppTextStyles.titleLogin,
        textAlign: TextAlign.center,
      ),
    );
  }
}
