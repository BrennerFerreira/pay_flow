import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../shared/user/models/user.dart';

class HomeAppBar {
  static PreferredSize appBar({
    required VoidCallback onLogOut,
    required User? user,
  }) =>
      PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.white,
                AppColors.primary,
              ],
              center: Alignment(0, 2.5),
              radius: 2,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text.rich(
                    TextSpan(
                      text: "Olá, ",
                      style: AppTextStyles.titleOnPrimary,
                      children: [
                        TextSpan(
                          text: user?.displayName ?? "Usuário",
                          style: AppTextStyles.titleBoldOnPrimary,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    "Matenha as suas contas em dia",
                    style: AppTextStyles.captionOnPrimary,
                  ),
                  trailing: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      image: user?.photoUrl != null
                          ? DecorationImage(
                              image: NetworkImage(
                              user!.photoUrl!,
                            ))
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: onLogOut,
                    child: Text(
                      "Sair",
                      style: AppTextStyles.buttonBoldOnPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
