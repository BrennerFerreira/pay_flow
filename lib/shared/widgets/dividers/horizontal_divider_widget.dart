import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class HorizontalDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColors.stroke,
    );
  }
}
