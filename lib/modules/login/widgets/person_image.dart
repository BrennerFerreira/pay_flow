import 'package:animated_card/animated_card.dart';
import 'package:boleto_organizer/app/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/images.dart';

class PersonImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.1,
      left: (size.width - 208) / 2,
      child: AnimatedCard(
        direction: AnimatedCardDirection.top,
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
          height: 373,
          width: 208,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment(0, 0.5),
                end: Alignment.bottomCenter,
                colors: [AppColors.white, Colors.transparent],
              ).createShader(
                Rect.fromLTRB(0, 0, rect.width, rect.height),
              );
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              AppImages.person,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
