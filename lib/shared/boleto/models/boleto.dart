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
  final DateTime? paidAt;

  Boleto._({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.price,
    required this.barCode,
    required this.paid,
    this.paidAt,
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

  String formatDate(DateTime date) {
    final int day = date.day;
    final int month = date.month;
    final int year = date.year;
    final String stringDay = day < 10 ? "0$day" : day.toString();
    final String stringMonth = month < 10 ? "0$month" : month.toString();
    return "$stringDay/$stringMonth/$year";
  }

  bool get pastDueDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final boletoDueDate = DateTime(dueDate.year, dueDate.month, dueDate.day);

    return !paid && boletoDueDate.isBefore(today);
  }

  String get dueDateFormatted => formatDate(dueDate);
  String get paidAtDateFormatted => formatDate(paidAt!);

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
    DateTime? paidAt,
  }) {
    return Boleto._(
        id: id ?? this.id,
        name: name ?? this.name,
        dueDate: dueDate ?? this.dueDate,
        price: price ?? this.price,
        barCode: barCode ?? this.barCode,
        paid: paid ?? this.paid,
        paidAt: paidAt ?? this.paidAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'price': price,
      'barCode': barCode,
      'paid': paid,
      'paidAt': paidAt?.millisecondsSinceEpoch,
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
      paidAt: map['paidAt'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['paidAt'] as int),
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
        other.paid == paid &&
        other.paidAt == paidAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dueDate.hashCode ^
        price.hashCode ^
        barCode.hashCode ^
        paid.hashCode ^
        paidAt.hashCode;
  }
}
