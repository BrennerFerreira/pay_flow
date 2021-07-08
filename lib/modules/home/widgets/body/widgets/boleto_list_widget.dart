import 'package:flutter/material.dart';

import '../../../../../shared/boleto/models/boleto.dart';
import '../../../controllers/boleto_list_controller.dart';
import 'boleto_list_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController controller;

  const BoletoListWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Boleto>>(
        valueListenable: widget.controller.boletosNotifier,
        builder: (_, boletos, __) {
          return ListView.builder(
            itemCount: widget.controller.boletos.length,
            itemBuilder: (context, index) {
              return BoletoListTileWidget(
                  boleto: widget.controller.boletos[index]);
            },
          );
        });
  }
}
