import 'package:flutter/material.dart';

import 'app/firebase_app.dart';
import 'flavor.dart';
import 'injectable.dart';

void main() {
  configureDependencies();
  runApp(const AppFirebase(AppFlavor.PROD));
}
