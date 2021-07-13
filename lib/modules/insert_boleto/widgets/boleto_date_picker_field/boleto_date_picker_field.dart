import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../shared/widgets/dividers/horizontal_divider_widget.dart';
import '../../../../shared/widgets/dividers/vertical_divider_widget.dart';
import '../../controller/insert_boleto_controller.dart';

class BoletoDatePickerField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _fieldController = TextEditingController(
      text: context.watch<InsertBoletoController>().boleto.dueDateFormatted,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AnimatedCard(
        direction: AnimatedCardDirection.left,
        child: Consumer<InsertBoletoController>(
          builder: (context, controller, _) {
            return Column(
              children: [
                GestureDetector(
                  onTap: controller.isLoading
                      ? null
                      : () async {
                          final newDate = await showDatePicker(
                              context: context,
                              initialDate: controller.boleto.dueDate,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2100),
                              cancelText: "Cancelar",
                              confirmText: "Confirmar",
                              locale: const Locale("pt", "BR"));

                          if (newDate != null) {
                            controller.onChange(dueDate: newDate);
                          }
                        },
                  child: TextFormField(
                    controller: _fieldController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      icon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(
                              FontAwesomeIcons.timesCircle,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            child: VerticalDividerWidget(),
                          ),
                        ],
                      ),
                      labelText: "Vencimento (dd/mm/aaaa)",
                      labelStyle: AppTextStyles.input,
                      border: InputBorder.none,
                      errorMaxLines: 2,
                    ),
                    enabled: false,
                    style: AppTextStyles.input,
                  ),
                ),
                HorizontalDividerWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
