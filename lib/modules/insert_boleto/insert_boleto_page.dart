import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes_names.dart';
import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/widgets/label_buttons_set/label_buttons_set.dart';
import 'controller/insert_boleto_controller.dart';
import 'widgets/boleto_date_picker_field/boleto_date_picker_field.dart';
import 'widgets/error_toast/error_toast.dart';
import 'widgets/input_text/input_text_widget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barCode;

  const InsertBoletoPage({Key? key, this.barCode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  late InsertBoletoController _pageController;
  late FToast fToast;

  final _moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$");

  final _barCodeInputTextController = MaskedTextController(
    mask: "00000.00000 00000.000000 00000.000000 0 00000000000000",
  );

  @override
  void initState() {
    super.initState();
    _pageController = context.read<InsertBoletoController>();
    if (widget.barCode != null) {
      _barCodeInputTextController.text = widget.barCode!;
      _pageController.setBoletoBarCode(widget.barCode!);
    }
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
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
                key: _pageController.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      textInputType: TextInputType.name,
                      onChanged: (value) {
                        _pageController.onChange(name: value);
                      },
                      validator: (_) => _pageController.validateName(),
                    ),
                    BoletoDatePickerField(),
                    InputTextWidget(
                      controller: _moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (_) {
                        _pageController.onChange(
                          price: _moneyInputTextController.numberValue,
                        );
                      },
                      validator: (_) => _pageController.validatePrice(),
                    ),
                    InputTextWidget(
                      controller: _barCodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        _pageController.onChange(
                          barCode: _barCodeInputTextController.text
                              .replaceAll(".", "")
                              .replaceAll(" ", ""),
                        );
                      },
                      validator: (_) => _pageController.validateBarCode(),
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
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          final newBoleto = await _pageController.submitBoleto();

          if (newBoleto == null) {
            fToast.showToast(
              child: ErrorToast(),
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
  }
}
