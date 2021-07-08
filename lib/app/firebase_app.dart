import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../flavor.dart';
import 'app_widget.dart';

class AppFirebase extends StatefulWidget {
  final AppFlavor flavor;
  const AppFirebase(this.flavor, {Key? key}) : super(key: key);

  @override
  _AppFirebaseState createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: _initialization,
      builder: (context, firebaseApp) {
        if (firebaseApp.hasError) {
          return const Material(
            child: Center(
              child: Text(
                "Erro ao inicializar o app. Por favor, verifique sua conexão e "
                "tente novamente.",
              ),
            ),
          );
        } else if (firebaseApp.connectionState == ConnectionState.done) {
          return AppWidget(widget.flavor);
        }

        return const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
