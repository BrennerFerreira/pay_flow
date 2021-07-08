import 'package:flutter/material.dart';

import 'app/firebase_app.dart';
import 'flavor.dart';

void main() {
  runApp(const AppFirebase(AppFlavor.PROD));
}
