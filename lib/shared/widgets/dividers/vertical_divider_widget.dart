import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class VerticalDividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 1,
      color: AppColors.stroke,
    );
  }
}
