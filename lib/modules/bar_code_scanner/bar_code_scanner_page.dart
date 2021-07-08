import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/widgets/bottom_sheet_widget/bottom_sheet_widget.dart';
import '../../shared/widgets/label_buttons_set/label_buttons_set.dart';
import 'controller/bar_code_scanner_controller.dart';
import 'controller/status/bar_code_scanner_status.dart';

class BarCodeScannerPage extends StatefulWidget {
  const BarCodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarCodeScannerPageState createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {
  final _controller = BarCodeScannerController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarBrightness: Brightness.light,
      ),
    );

    _controller.getAvailableCameras();
    _controller.statusNotifier.addListener(() {
      if (_controller.status.hasBarCode) {
        Navigator.pushReplacementNamed(
          context,
          INSERT_BOLETO_ROUTE,
          arguments: _controller.status.barCode,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarCodeScannerStatus>(
            valueListenable: _controller.statusNotifier,
            builder: (_, status, __) {
              if (status.canShowCamera) {
                return Container(
                  child: _controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: AppColors.black,
                title: Text(
                  "Escaneie o código de barras do boleto",
                  style: AppTextStyles.buttonOnPrimary,
                ),
                leading: const BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColors.black.withOpacity(0.6),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: LabelButtonsSet(
                primaryLabel: "Inserir código",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(context, INSERT_BOLETO_ROUTE);
                },
                secondaryLabel: "Procurar na galeria",
                secondaryOnPressed: _controller.scanGalleryImage,
              ),
            ),
          ),
          ValueListenableBuilder<BarCodeScannerStatus>(
            valueListenable: _controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return BottomSheetWidget(
                  title: "Não foi possível identificar um código de barras",
                  subtitle: "Tente novamente ou digite o código do seu boleto",
                  primaryLabel: "Escanear novamente",
                  primaryOnPressed: _controller.scanWithCamera,
                  secondaryLabel: "Digitar código",
                  secondaryOnPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      INSERT_BOLETO_ROUTE,
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );

    super.dispose();
  }
}
