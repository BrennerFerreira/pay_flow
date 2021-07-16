import 'package:flutter/material.dart';

import '../../../app/theme/text_styles.dart';
import '../../../shared/widgets/label_button/label_button.dart';

class LineLabelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const LineLabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: LabelButton(
        label: label,
        onPressed: onPressed,
        style: AppTextStyles.buttonBoldPrimary,
      ),
    );
  }
}
