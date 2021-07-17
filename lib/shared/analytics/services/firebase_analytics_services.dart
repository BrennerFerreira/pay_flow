import 'package:boleto_organizer/shared/analytics/services/i_analytics_services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAnalyticsServices)
class FirebaseAnalyticsServices implements IAnalyticsServices {
  final FirebaseAnalyticsObserver _observer;

  FirebaseAnalyticsServices(this._observer);
  @override
  NavigatorObserver getObserver() {
    return _observer;
  }

  @override
  void sendCurrentTabToAnalytics(String tab) {
    _observer.analytics.setCurrentScreen(
      screenName: 'home/$tab',
    );
  }

  @override
  void newPageAccessed(String screenName) {
    _observer.analytics.setCurrentScreen(screenName: screenName);
  }

  @override
  void setUserId(String userId) {
    _observer.analytics.setUserId(userId);
  }
}
