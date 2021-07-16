import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/boleto/models/boleto.dart';
import '../../../controllers/boleto_list_controller.dart';
import 'boleto_list_tile_widget.dart';

class BoletoListWidget extends StatelessWidget {
  final bool showPaidBoletos;

  const BoletoListWidget({
    Key? key,
    this.showPaidBoletos = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<BoletoListController>(
      builder: (_, boletoList, __) {
        return StreamBuilder<List<Boleto>>(
            stream: showPaidBoletos
                ? boletoList.getPaidBoletos()
                : boletoList.getUnpaidBoletos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Erro ao buscar os boletos salvos. Por favor, tente novamente",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return BoletoListTileWidget(
                    boleto: snapshot.data![index],
                  );
                },
              );
            });
      },
    );
  }
}
