import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/analytics/controller/analytics_controller.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    context.read<AnalyticsController>().newPageAccessed("privacy-policy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Política de Privacidade"),
      ),
      body: const WebView(
        initialUrl:
            'https://docs.google.com/document/d/1SnBxHWgzW-bRl-kb_0L1ZdeQtrQuimdmD6ZV2LBfhmc/edit?usp=sharing',
      ),
    );
  }
}
