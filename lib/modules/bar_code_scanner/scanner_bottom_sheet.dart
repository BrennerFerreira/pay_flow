import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import 'controller/bar_code_scanner_controller.dart';
import 'widgets/line_label_button.dart';

class ScannerBottomSheet extends StatelessWidget {
  const ScannerBottomSheet({Key? key}) : super(key: key);

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
                          onPressed: () async {
                            final image = await ImagePicker().getImage(
                              source: ImageSource.camera,
                            );

                            if (image != null) {
                              final File imageFile = File(image.path);
                              final barCode =
                                  await controller.scanImage(imageFile);

                              if (barCode != null) {
                                Navigator.of(context).popAndPushNamed(
                                  INSERT_BOLETO_ROUTE,
                                  arguments: barCode,
                                );
                              }
                            }
                          },
                        ),
                        LineLabelButton(
                          label: "Escolher imagem da galeria",
                          onPressed: () async {
                            final image = await ImagePicker().getImage(
                              source: ImageSource.gallery,
                            );

                            if (image != null) {
                              final File imageFile = File(image.path);
                              final barCode =
                                  await controller.scanImage(imageFile);

                              if (barCode != null) {
                                Navigator.of(context).popAndPushNamed(
                                  INSERT_BOLETO_ROUTE,
                                  arguments: barCode,
                                );
                              }
                            }
                          },
                        ),
                        LineLabelButton(
                          label: "Digitar código",
                          onPressed: () {
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
