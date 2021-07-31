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
  void appOpen() {
    _analytics.logAppOpen();
  }

  @override
  void sendCurrentTabToAnalytics(String tab) {
    _analytics.setCurrentScreen(
      screenName: '/home/$tab',
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
  void userLoggedOut() {
    _analytics.logEvent(name: 'user_log_out');
  }

  @override
  void addBoletoPressed() {
    _analytics.logEvent(name: "add_boleto_pressed");
  }

  @override
  void insertBoletoStarted(String method) {
    _analytics.logEvent(name: "insert_boleto_started", parameters: {
      "method": method,
    });
  }

  @override
  void barCodeScanSuccess() {
    _analytics.logEvent(name: "bar_code_scan_success");
  }

  @override
  void barCodeScanError(String error) {
    _analytics.logEvent(name: "bar_code_scan_error", parameters: {
      "error": error,
    });
  }

  @override
  void boletoSaveSuccess() {
    _analytics.logEvent(name: "boleto_save_success");
  }

  @override
  void boletoSaveError() {
    _analytics.logEvent(name: "boleto_save_error");
  }

  @override
  void boletoSaveCancel() {
    _analytics.logEvent(name: "boleto_save_cancel");
  }

  @override
  void markBoletoAsPaid() {
    _analytics.logEvent(name: "boleto_paid");
  }

  @override
  void boletoDeleted() {
    _analytics.logEvent(name: "boleto_deleted");
  }
}
