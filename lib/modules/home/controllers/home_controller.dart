import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/auth/controller/auth_controller.dart';

@injectable
class HomePageController with ChangeNotifier {
  final AuthController _authController;

  int _currentPage = 0;

  HomePageController(this._authController);

  int get currentPage => _currentPage;

  void _onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void onHomePressed() => _onPageChanged(0);

  void onDescriptionPressed() => _onPageChanged(1);

  Future<bool> logOut() async {
    return _authController.logOut();
  }
}
