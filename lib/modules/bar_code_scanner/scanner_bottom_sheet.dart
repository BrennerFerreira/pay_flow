import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/analytics/controller/analytics_controller.dart';
import 'controller/bar_code_scanner_controller.dart';
import 'widgets/line_label_button.dart';

class ScannerBottomSheet extends StatelessWidget {
  const ScannerBottomSheet({Key? key}) : super(key: key);

  Future<void> _scanBarCode({
    required BuildContext context,
    required BarCodeScannerController controller,
    required ImageSource source,
  }) async {
    context.read<AnalyticsController>().insertBoletoStarted(
          source == ImageSource.camera ? "camera" : "gallery",
        );

    final image = await ImagePicker().pickImage(
      source: source,
    );

    if (image != null) {
      final File imageFile = File(image.path);
      final barCode = await controller.scanImage(imageFile);

      if (barCode != null) {
        context.read<AnalyticsController>().barCodeScanSuccess();

        Navigator.of(context).popAndPushNamed(
          INSERT_BOLETO_ROUTE,
          arguments: barCode,
        );
      }
    } else {
      context.read<AnalyticsController>().barCodeScanError(controller.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BarCodeScannerController(),
      builder: (context, _) => Consumer<BarCodeScannerController>(
        builder: (_, controller, __) => BottomSheet(
          onClosing: controller.isLoading
              ? controller.dispose
              : Navigator.of(context).pop,
          builder: (_) {
            return Material(
              color: AppColors.background,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      controller.message,
                      style: AppTextStyles.titleRegular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (controller.isLoading)
                    SizedBox(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  else
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LineLabelButton(
                          label: "Tirar foto com a câmera",
                          onPressed: controller.isLoading
                              ? null
                              : () async => _scanBarCode(
                                    context: context,
                                    controller: controller,
                                    source: ImageSource.camera,
                                  ),
                        ),
                        LineLabelButton(
                          label: "Escolher imagem da galeria",
                          onPressed: controller.isLoading
                              ? null
                              : () async => _scanBarCode(
                                    context: context,
                                    controller: controller,
                                    source: ImageSource.gallery,
                                  ),
                        ),
                        LineLabelButton(
                          label: "Digitar código",
                          onPressed: controller.isLoading
                              ? null
                              : () {
                                  context
                                      .read<AnalyticsController>()
                                      .insertBoletoStarted("manual");

                                  Navigator.of(context).popAndPushNamed(
                                    INSERT_BOLETO_ROUTE,
                                  );
                                },
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
