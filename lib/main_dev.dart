import 'package:boleto_organizer/injectable.dart';
import 'package:flutter/material.dart';

import 'app/firebase_app.dart';
import 'flavor.dart';

void main() {
  configureDependencies();
  runApp(const AppFirebase(AppFlavor.DEV));
}
