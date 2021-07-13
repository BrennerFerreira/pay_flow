import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../helpers/convert_bar_code_string.dart';
import '../helpers/get_due_date_and_value_from_bar_code.dart';

class Boleto {
  final String id;
  final String name;
  final DateTime dueDate;
  final double price;
  final String barCode;
  final bool paid;

  Boleto._({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.price,
    required this.barCode,
    required this.paid,
  });

  factory Boleto.empty() {
    return Boleto._(
      id: const Uuid().v4(),
      name: "",
      dueDate: DateTime.now(),
      price: 0.00,
      barCode: "",
      paid: false,
    );
  }

  factory Boleto.fromBarCode(String barCode) {
    final boletoData = GetDataFromBarCode(barCode);
    final dueDate = boletoData.getDueDate();
    final value = boletoData.getValue();

    return Boleto._(
      id: const Uuid().v4(),
      barCode: barCode,
      dueDate: dueDate ?? DateTime.now(),
      price: value ?? 0.00,
      name: "",
      paid: false,
    );
  }

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
    String? id,
    String? name,
    DateTime? dueDate,
    double? price,
    String? barCode,
    bool? paid,
  }) {
    return Boleto._(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      price: price ?? this.price,
      barCode: barCode ?? this.barCode,
      paid: paid ?? this.paid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'price': price,
      'barCode': barCode,
      'paid': paid,
    };
  }

  factory Boleto.fromMap(Map<String, dynamic> map) {
    return Boleto._(
      id: map['id'] as String,
      name: map['name'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      price: map['price'] as double,
      barCode: map['barCode'] as String,
      paid: map['paid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Boleto.fromJson(String source) => Boleto.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'Boleto(id: $id, name: $name, dueDate: $dueDate, price: $price, barCode: $barCode, paid: $paid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Boleto &&
        other.id == id &&
        other.name == name &&
        other.dueDate == dueDate &&
        other.price == price &&
        other.barCode == barCode &&
        other.paid == paid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dueDate.hashCode ^
        price.hashCode ^
        barCode.hashCode ^
        paid.hashCode;
  }
}
