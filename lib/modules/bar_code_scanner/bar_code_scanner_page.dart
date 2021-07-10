import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/widgets/bottom_sheet_widget/bottom_sheet_widget.dart';
import '../../shared/widgets/label_buttons_set/label_buttons_set.dart';
import 'controller/bar_code_scanner_controller.dart';

class BarCodeScannerPage extends StatefulWidget {
  const BarCodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarCodeScannerPageState createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarBrightness: Brightness.light,
      ),
    );
    final controller = context.read<BarCodeScannerController>();
    controller.startScan();
    controller.addListener(() {
      if (controller.status.hasBarCode) {
        Navigator.pushReplacementNamed(
          context,
          INSERT_BOLETO_ROUTE,
          arguments: controller.status.barCode,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Consumer<BarCodeScannerController>(
            builder: (_, controller, __) {
              if (controller.isLoading) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              return Container(
                child: controller.cameraController?.buildPreview(),
              );
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
                  style: AppTextStyles.titleOnPrimary,
                ),
                leading: BackButton(
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
              bottomNavigationBar: Consumer<BarCodeScannerController>(
                builder: (context, controller, _) {
                  return LabelButtonsSet(
                    primaryLabel: "Inserir código",
                    primaryOnPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        INSERT_BOLETO_ROUTE,
                      );
                    },
                    secondaryLabel: "Procurar na galeria",
                    secondaryOnPressed: () async {
                      final image = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                      );

                      if (image != null) {
                        final File imageFile = File(image.path);
                        controller.scanGalleryImage(imageFile);
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Consumer<BarCodeScannerController>(
            builder: (_, controller, __) {
              if (controller.status.hasError) {
                return BottomSheetWidget(
                  title: "Não foi possível identificar um código de barras",
                  subtitle: "Tente novamente ou digite o código do seu boleto",
                  primaryLabel: "Escanear novamente",
                  primaryOnPressed: controller.startScan,
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
    context.read<BarCodeScannerController>().dispose();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );

    super.dispose();
  }
}
