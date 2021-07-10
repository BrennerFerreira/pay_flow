import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../dividers/horizontal_divider_widget.dart';
import '../label_buttons_set/label_buttons_set.dart';

class BottomSheetWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback? primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback? secondaryOnPressed;
  final String title;
  final String subtitle;

  const BottomSheetWidget({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.background,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text.rich(
                        TextSpan(
                          text: title,
                          style: AppTextStyles.buttonBoldSecondary,
                          children: [
                            TextSpan(
                              text: "\n$subtitle",
                              style: AppTextStyles.buttonSecondary,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    HorizontalDividerWidget(),
                    LabelButtonsSet(
                      primaryLabel: primaryLabel,
                      primaryOnPressed: primaryOnPressed,
                      enablePrimaryColor: true,
                      secondaryLabel: secondaryLabel,
                      secondaryOnPressed: secondaryOnPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
