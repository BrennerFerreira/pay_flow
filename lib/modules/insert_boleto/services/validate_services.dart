class ValidateServices {
  String? _baseValidator(String? value, String stringToReturn) {
    if (value == null || value.isEmpty) {
      return stringToReturn;
    }

    return null;
  }

  String? validateName(String? value) {
    return _baseValidator(value, "Insira um nome para o seu boleto");
  }

  String? validateDueDate(String? value) {
    return _baseValidator(
      value,
      "Insira a data de vencimento do boleto no formato dia/mês/ano",
    );
  }

  String? validatePrice(double? value) {
    if (value == null) {
      return "Insira o valor do boleto";
    }

    if (value <= 0) {
      return "Insira um valor válido para o boleto";
    }

    return null;
  }

  String? validateBarCode(String? value) {
    return _baseValidator(value, "Insira o código do seu boleto");
  }
}
