import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'i_analytics_services.dart';

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

  @override
  void insertBoletoStarted(String method) {
    _analytics.logEvent(name: "insert-boleto-started", parameters: {
      "method": method,
    });
  }

  @override
  void barCodeScanSuccess() {
    _analytics.logEvent(name: "bar-code-scan-success");
  }

  @override
  void barCodeScanError(String error) {
    _analytics.logEvent(name: "bar-code-scan-error", parameters: {
      "error": error,
    });
  }

  @override
  void boletoSaveSuccess() {
    _analytics.logEvent(name: "boleto-save-success");
  }

  @override
  void boletoSaveError() {
    _analytics.logEvent(name: "boleto-save-error");
  }

  @override
  void boletoSaveCancel() {
    _analytics.logEvent(name: "boleto-save-cancel");
  }
}
