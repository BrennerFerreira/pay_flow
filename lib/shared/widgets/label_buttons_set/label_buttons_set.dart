import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../dividers/horizontal_divider_widget.dart';
import '../dividers/vertical_divider_widget.dart';
import '../label_button/label_button.dart';

class LabelButtonsSet extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback? primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback? secondaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;

  const LabelButtonsSet({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HorizontalDividerWidget(),
          SizedBox(
            height: 51,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style: primaryOnPressed == null
                        ? AppTextStyles.buttonDisabled
                        : enablePrimaryColor
                            ? AppTextStyles.buttonPrimary
                            : null,
                  ),
                ),
                SizedBox(height: 51, child: VerticalDividerWidget()),
                Expanded(
                  child: LabelButton(
                    label: secondaryLabel,
                    onPressed: secondaryOnPressed,
                    style: secondaryOnPressed == null
                        ? AppTextStyles.buttonDisabled
                        : enableSecondaryColor
                            ? AppTextStyles.buttonPrimary
                            : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
