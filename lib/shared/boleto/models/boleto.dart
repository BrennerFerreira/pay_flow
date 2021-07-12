import 'dart:convert';

import '../helpers/convert_bar_code_string.dart';
import '../helpers/get_due_date_and_value_from_bar_code.dart';

class Boleto {
  final String name;
  final DateTime dueDate;
  final double price;
  final String barCode;

  Boleto({
    required this.name,
    required this.dueDate,
    required this.price,
    required this.barCode,
  });

  factory Boleto.empty() {
    return Boleto(
      name: "",
      dueDate: DateTime.now(),
      price: 0.00,
      barCode: "",
    );
  }

  factory Boleto.fromBarCode(String barCode) {
    final boletoData = GetDataFromBarCode(barCode);
    final dueDate = boletoData.getDueDate();
    final value = boletoData.getValue();

    return Boleto(
      barCode: barCode,
      dueDate: dueDate ?? DateTime.now(),
      price: value ?? 0.00,
      name: "",
    );
  }

  String get priceFormatted => price.toStringAsFixed(2).replaceAll(".", ",");
  String get barCodeRaw => barCode.replaceAll(RegExp("[^0-9]"), "");

  String get dateFormatted {
    final int day = dueDate.day;
    final int month = dueDate.month;
    final int year = dueDate.year;
    final String stringDay = day < 10 ? "0$day" : day.toString();
    final String stringMonth = month < 10 ? "0$month" : month.toString();
    return "$stringDay/$stringMonth/$year";
  }

  String? convertBarCode(String barCode) {
    return ConvertBarCodeString.calculateRow(barCode);
  }

  Boleto copyWith({
    String? name,
    DateTime? dueDate,
    double? price,
    String? barCode,
  }) {
    return Boleto(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      price: price ?? this.price,
      barCode: barCode ?? this.barCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'price': price,
      'barCode': barCode,
    };
  }

  factory Boleto.fromMap(Map<String, dynamic> map) {
    return Boleto(
      name: map['name'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      price: map['price'] as double,
      barCode: map['barCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Boleto.fromJson(String source) =>
      Boleto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Boleto(name: $name, dueDate: $dueDate, price: $price, barCode: $barCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Boleto &&
        other.name == name &&
        other.dueDate == dueDate &&
        other.price == price &&
        other.barCode == barCode;
  }

  @override
  int get hashCode {
    return name.hashCode ^ dueDate.hashCode ^ price.hashCode ^ barCode.hashCode;
  }
}
