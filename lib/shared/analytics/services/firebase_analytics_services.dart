import 'package:boleto_organizer/shared/analytics/services/i_analytics_services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAnalyticsServices)
class FirebaseAnalyticsServices implements IAnalyticsServices {
  final FirebaseAnalyticsObserver _observer;

  FirebaseAnalytics get _analytics => _observer.analytics;

  FirebaseAnalyticsServices(this._observer);
  @override
  NavigatorObserver getObserver() {
    return _observer;
  }

  @override
  void sendCurrentTabToAnalytics(String tab) {
    _analytics.setCurrentScreen(
      screenName: 'home/$tab',
    );
  }

  @override
  void newPageAccessed(String screenName) {
    _analytics.setCurrentScreen(screenName: screenName);
  }

  @override
  void setUserId(String userId) {
    _analytics.setUserId(userId);
  }

  @override
  void userLoggedIn(String method) {
    _analytics.logLogin(loginMethod: method);
  }

  @override
  void addBoletoPressed() {
    _analytics.logEvent(name: "add-boleto-pressed");
  }
}
