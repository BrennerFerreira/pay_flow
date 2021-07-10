import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../../shared/widgets/dividers/vertical_divider_widget.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;

  const InputTextWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.initialValue,
    this.validator,
    this.controller,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputType = TextInputType.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AnimatedCard(
        direction: AnimatedCardDirection.left,
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: VerticalDividerWidget(),
                    ),
                  ],
                ),
                labelText: label,
                labelStyle: AppTextStyles.input,
                border: InputBorder.none,
                errorMaxLines: 2,
              ),
              style: AppTextStyles.input,
              initialValue: initialValue,
              textCapitalization: textCapitalization,
              keyboardType: textInputType,
              validator: validator,
              onChanged: onChanged,
            ),
            HorizontalDividerWidget(),
          ],
        ),
      ),
    );
  }
}
