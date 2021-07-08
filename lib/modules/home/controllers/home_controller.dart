import 'package:flutter/material.dart';

import '../../../injectable.dart';
import '../../../shared/auth/controller/auth_controller.dart';

class HomePageController with ChangeNotifier {
  final _authController = getIt<AuthController>();

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void _onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void onHomePressed() => _onPageChanged(0);

  void onDescriptionPressed() => _onPageChanged(1);

  Future<void> logOut(BuildContext context) async {
    await _authController.logOut();
  }
}
