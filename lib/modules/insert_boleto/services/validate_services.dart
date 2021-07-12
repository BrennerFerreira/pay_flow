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
    final validateNotNullNorEmpty =
        _baseValidator(value, "Insira o código do seu boleto");

    if (validateNotNullNorEmpty != null) {
      return validateNotNullNorEmpty;
    }

    if (value!.replaceAll(RegExp("[^0-9]"), "").length != 47) {
      return "Insira um código válido para o seu boleto";
    }
  }
}
