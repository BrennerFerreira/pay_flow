import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/text_styles.dart';
import 'controller/local_auth_controller.dart';

class LocalAuthPage extends StatefulWidget {
  final String source;

  const LocalAuthPage({Key? key, required this.source}) : super(key: key);

  @override
  _LocalAuthPageState createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  @override
  void initState() {
    super.initState();

    context.read<LocalAuthController>().authenticationRequested().then(
      (value) {
        if (value) {
          Navigator.of(context).pushReplacementNamed(HOME_ROUTE);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalAuthController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return controller.authFail
            ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "A autenticação falhou.",
                        style: AppTextStyles.titleBold,
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            await controller.authenticationRequested();

                            if (controller.isAuthenticated) {
                              Navigator.of(context)
                                  .pushReplacementNamed(HOME_ROUTE);
                            }
                          },
                          child: const Text("Tentar novamente"),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
