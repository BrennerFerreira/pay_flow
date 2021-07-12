class GetDataFromBarCode {
  final String barCode;

  GetDataFromBarCode(this.barCode);

  String? _validateBarCode() {
    if (barCode.replaceAll(RegExp("[^0-9]"), "").length != 47) {
      return "Invalid bar code";
    }
  }

  String _getLastFieldFromBarCode() {
    final fields = barCode.split(" ");

    return fields.last;
  }

  DateTime? getDueDate() {
    if (_validateBarCode() != null) {
      return null;
    }

    final lastField = _getLastFieldFromBarCode();

    final dateField = lastField.substring(0, 4);

    if (dateField == "0000") {
      return DateTime.now();
    }

    final intDateField = int.tryParse(dateField);

    if (intDateField == null) {
      return null;
    }

    final baseDate = DateTime(1997, 10, 7);

    final dueDate = baseDate.add(Duration(days: intDateField + 1));

    return dueDate;
  }

  double? getValue() {
    if (_validateBarCode() != null) {
      return null;
    }

    final lastField = _getLastFieldFromBarCode();

    final valueField = lastField.substring(4);

    final doubleValueField = double.tryParse(valueField);

    if (doubleValueField == null) {
      return null;
    }

    final value = doubleValueField / 100;

    return value;
  }
}
