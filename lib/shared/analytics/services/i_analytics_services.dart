import 'package:flutter/material.dart';

abstract class IAnalyticsServices {
  NavigatorObserver getObserver();
  void sendCurrentTabToAnalytics(String tab);
  void newPageAccessed(String screenName);
  void setUserId(String userId);
  void userLoggedIn(String method);
  void addBoletoPressed();
  void insertBoletoStarted(String method);
  void barCodeScanSuccess();
  void barCodeScanError(String error);
}
