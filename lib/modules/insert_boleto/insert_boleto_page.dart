import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/text_styles.dart';
import '../../shared/widgets/label_buttons_set/label_buttons_set.dart';
import 'controller/insert_boleto_controller.dart';
import 'widgets/input_text/input_text_widget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barCode;

  const InsertBoletoPage({Key? key, this.barCode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final _pageController = InsertBoletoController();

  final _moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$");

  final _dateInputTextController = MaskedTextController(mask: "00/00/0000");

  final _barCodeInputTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.barCode != null) {
      _barCodeInputTextController.text = widget.barCode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(
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
                      onChanged: (value) {
                        _pageController.onChange(name: value);
                      },
                      validator: _pageController.validateName,
                    ),
                    InputTextWidget(
                      controller: _dateInputTextController,
                      label: "Vencimento (dd/mm/aaaa)",
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        _pageController.onChange(dueDate: value);
                      },
                      validator: _pageController.validateDueDate,
                    ),
                    InputTextWidget(
                      controller: _moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (_) {
                        _pageController.onChange(
                          price: _moneyInputTextController.numberValue,
                        );
                      },
                      validator: (_) => _pageController.validatePrice(
                        _moneyInputTextController.numberValue,
                      ),
                    ),
                    InputTextWidget(
                      controller: _barCodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        _pageController.onChange(barCode: value);
                      },
                      validator: _pageController.validateBarCode,
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
          await _pageController.submitBoleto();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
