class _ResponseType {
  final String? error;
  final String? barCode;

  _ResponseType({this.error, this.barCode});
}

class ConvertBarCodeString {
  static final RegExp _regExp = RegExp("[^0-9]");
  static _ResponseType calculateRow(String barCode) {
    // Remover caracteres não numéricos.
    final String row = barCode.replaceAll(_regExp, "");

    if (row.length != 44) {
      return _ResponseType(
        error:
            "Não foi possível encontrar o valor correto do código de barras.",
      ); // 'A linha do Código de Barras está incompleta!'
    }

    final String field1 =
        "${row.substring(0, 4)}${row.substring(19, 20)}.${row.substring(20, 24)}";
    final String field2 = "${row.substring(24, 29)}.${row.substring(29, 34)}";
    final String field3 = "${row.substring(34, 39)}.${row.substring(39, 44)}";
    final String field4 = row.substring(4, 5); // Digito verificador
    final String field5 = row.substring(5, 19); // Vencimento + Valor

    if (_module11Bank("${row.substring(0, 4)}${row.substring(5, 44)}") !=
        int.parse(field4)) {
      //'Digito verificador '+campo4+', o correto é
      //'+modulo11_banco(  linha.substr(0,4)+linha.substr(5,99)  )+
      //'O sistema não altera automaticamente o dígito correto na quinta casa!'
      return _ResponseType(
        error: "Erro ao converter o código para a linha digitável.",
      );
    }

    return _ResponseType(
      barCode: "$field1${_module10(field1)} $field2${_module10(field2)} "
          "$field3${_module10(field3)} $field4 $field5",
    );
  }

  static int _module10(String numberRaw) {
    final String number = numberRaw.replaceAll(_regExp, "");
    int sum = 0;
    int weight = 2;
    int counter = number.length - 1;
    while (counter >= 0) {
      int multiplier =
          int.parse(number.substring(counter, counter + 1)) * weight;

      if (multiplier >= 10) {
        multiplier = 1 + (multiplier - 10);
      }

      sum = sum + multiplier;

      if (weight == 2) {
        weight = 1;
      } else {
        weight = 2;
      }

      counter = counter - 1;
    }
    int digit = 10 - (sum % 10);

    if (digit == 10) {
      digit = 0;
    }

    return digit;
  }

  static int _module11Bank(String numberRaw) {
    final String number = numberRaw.replaceAll(_regExp, "");

    int sum = 0;
    int weight = 2;
    const int base = 9;
    final int counter = number.length - 1;
    for (int i = counter; i >= 0; i--) {
      sum = sum + (int.parse(number.substring(i, i + 1)) * weight);
      if (weight < base) {
        weight++;
      } else {
        weight = 2;
      }
    }

    int digit = 11 - (sum % 11);

    if (digit > 9) {
      digit = 0;
    }
    /* Utilizar o dígito 1(um) sempre que o resultado do cálculo padrão for igual a 0(zero), 1(um) ou 10(dez). */
    if (digit == 0) {
      digit = 1;
    }

    return digit;
  }
}
