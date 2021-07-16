import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/widgets/label_buttons_set/label_buttons_set.dart';
import '../../shared/widgets/toast/toast.dart';
import 'controller/insert_boleto_controller.dart';
import 'widgets/boleto_date_picker_field/boleto_date_picker_field.dart';
import 'widgets/input_text/input_text_widget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barCode;

  const InsertBoletoPage({Key? key, this.barCode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final _regExp = RegExp("[^0-9]");
  late FToast fToast;

  final _moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$ ");

  final _barCodeInputTextController = MaskedTextController(
    mask: "00000.00000 00000.000000 00000.000000 0 00000000000000",
  );

  @override
  void initState() {
    super.initState();
    final _pageController = context.read<InsertBoletoController>();

    if (widget.barCode != null) {
      _barCodeInputTextController.text =
          widget.barCode!.replaceAll(_regExp, "");

      _pageController.setBoletoBarCode(widget.barCode!);
      _moneyInputTextController.updateValue(_pageController.boleto.price);
    }

    _pageController.addListener(() {
      if (_pageController.updatePrice) {
        _moneyInputTextController.updateValue(_pageController.boleto.price);
      }
    });

    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InsertBoletoController>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: controller.isLoading
              ? null
              : BackButton(
                  color: AppColors.input,
                ),
        ),
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 24,
                        ),
                        child: Text(
                          "Preencha os dados do boleto",
                          style: AppTextStyles.titleBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            InputTextWidget(
                              label: "Nome do boleto",
                              icon: Icons.description_outlined,
                              textInputType: TextInputType.name,
                              enabled: !controller.isLoading,
                              onChanged: (value) {
                                controller.onChange(name: value);
                              },
                              validator: (_) => controller.validateName(),
                            ),
                            InputTextWidget(
                              controller: _barCodeInputTextController,
                              label: "Código",
                              icon: FontAwesomeIcons.barcode,
                              enabled: !controller.isLoading,
                              onChanged: (_) {
                                controller.onBarCodeChange(
                                  _barCodeInputTextController.text,
                                );
                              },
                              validator: (_) => controller.validateBarCode(),
                            ),
                            BoletoDatePickerField(),
                            InputTextWidget(
                              controller: _moneyInputTextController,
                              label: "Valor",
                              icon: FontAwesomeIcons.wallet,
                              enabled: !controller.isLoading,
                              onChanged: (_) {
                                controller.onChange(
                                  price: _moneyInputTextController.numberValue,
                                );
                              },
                              validator: (_) => controller.validatePrice(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: LabelButtonsSet(
          primaryLabel: "Cancelar",
          primaryOnPressed: controller.isLoading
              ? null
              : () {
                  Navigator.pop(context);
                },
          secondaryLabel: "Cadastrar",
          secondaryOnPressed: controller.isLoading
              ? null
              : () async {
                  final newBoleto = await controller.submitBoleto();

                  if (newBoleto == null) {
                    fToast.showToast(
                      child: const CustomToast(
                        color: AppColors.delete,
                        icon: Icons.error,
                        label:
                            "Erro ao salvar o boleto. Por favor, tente novamente.",
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HOME_ROUTE,
                      (route) => false,
                    );
                  }
                },
          enableSecondaryColor: true,
        ),
      );
    });
  }
}
