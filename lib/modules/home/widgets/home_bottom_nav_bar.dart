import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/routes_names.dart';
import '../../../app/theme/colors.dart';
import '../controllers/boleto_list_controller.dart';
import '../controllers/home_controller.dart';

class HomeBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              context.read<HomePageController>().onHomePressed();
            },
            icon: const Icon(Icons.home),
            color: context.watch<HomePageController>().currentPage == 0
                ? AppColors.primary
                : AppColors.body,
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  BAR_CODE_SCANNER_ROUTE,
                );
              },
              icon: const Icon(Icons.add_box_outlined),
              color: AppColors.background,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<HomePageController>().onDescriptionPressed();
            },
            icon: const Icon(Icons.description_outlined),
            color: context.watch<HomePageController>().currentPage == 1
                ? AppColors.primary
                : AppColors.body,
          ),
        ],
      ),
    );
  }
}
