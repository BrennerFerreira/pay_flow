import 'package:flutter/material.dart';

abstract class IAnalyticsServices {
  NavigatorObserver getObserver();
  void sendCurrentTabToAnalytics(String tab);
  void newPageAccessed(String screenName);
}
