import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../services/i_analytics_services.dart';

@injectable
class AnalyticsController {
  final IAnalyticsServices _analyticsServices;

  AnalyticsController(this._analyticsServices);

  NavigatorObserver getObserver() {
    return _analyticsServices.getObserver();
  }

  void appOpen() {
    return _analyticsServices.appOpen();
  }

  void sendCurrentTabToAnalytics(String tab) {
    return _analyticsServices.sendCurrentTabToAnalytics(tab);
  }

  void newPageAccessed(String screenName) {
    return _analyticsServices.newPageAccessed(screenName);
  }

  void setUserId(String userId) {
    return _analyticsServices.setUserId(userId);
  }

  void userLoggedIn(String method) {
    return _analyticsServices.userLoggedIn(method);
  }

  void addBoletoPressed() {
    return _analyticsServices.addBoletoPressed();
  }

  void insertBoletoStarted(String method) {
    return _analyticsServices.insertBoletoStarted(method);
  }

  void barCodeScanSuccess() {
    return _analyticsServices.barCodeScanSuccess();
  }

  void barCodeScanError(String error) {
    return _analyticsServices.barCodeScanError(error);
  }

  void boletoSaveSuccess() {
    return _analyticsServices.boletoSaveSuccess();
  }

  void boletoSaveError() {
    return _analyticsServices.boletoSaveError();
  }

  void boletoSaveCancel() {
    return _analyticsServices.boletoSaveCancel();
  }
}
