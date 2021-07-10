import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/boleto_list_controller.dart';
import 'boleto_list_tile_widget.dart';

class BoletoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoletoListController>(
      builder: (_, boletoList, __) {
        return ListView.builder(
          itemCount: boletoList.boletos.length,
          itemBuilder: (context, index) {
            return BoletoListTileWidget(
              boleto: boletoList.boletos[index],
            );
          },
        );
      },
    );
  }
}
