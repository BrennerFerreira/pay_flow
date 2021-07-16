import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/colors.dart';
import '../../bar_code_scanner/scanner_bottom_sheet.dart';
import '../controllers/home_controller.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({Key? key}) : super(key: key);
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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ScannerBottomSheet(),
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
