import 'package:flutter/material.dart';

import '../../../../../app/theme/colors.dart';
import '../../../../../shared/widgets/label_button/label_button.dart';

class StyledLabelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const StyledLabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.background,
        border: Border.all(color: AppColors.stroke),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: LabelButton(
        label: label,
        onPressed: onPressed,
      ),
    );
  }
}
