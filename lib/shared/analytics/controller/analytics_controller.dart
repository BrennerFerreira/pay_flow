import 'package:boleto_organizer/shared/analytics/services/i_analytics_services.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AnalyticsController {
  final IAnalyticsServices _analyticsServices;

  AnalyticsController(this._analyticsServices);

  NavigatorObserver getObserver() {
    return _analyticsServices.getObserver();
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
}
