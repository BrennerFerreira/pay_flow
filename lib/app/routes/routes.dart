import 'package:boleto_organizer/app/routes/routes_names.dart';
import 'package:boleto_organizer/modules/home/home_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  HOME_ROUTE: (_) => HomePage(),
};
