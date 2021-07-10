import 'package:flutter/material.dart';

import '../../../app/theme/text_styles.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final TextStyle? style;

  const LabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: style ?? AppTextStyles.buttonSecondary,
        ),
      ),
    );
  }
}
