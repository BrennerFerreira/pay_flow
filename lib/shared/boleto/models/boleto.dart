import 'dart:convert';

class Boleto {
  final String? name;
  final String? dueDate;
  final double? price;
  final String? barCode;

  Boleto({
    this.name,
    this.dueDate,
    this.price,
    this.barCode,
  });

  Boleto copyWith({
    String? name,
    String? dueDate,
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

  String get priceFormatted => price!.toStringAsFixed(2).replaceAll(".", ",");

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dueDate': dueDate,
      'price': price,
      'barCode': barCode,
    };
  }

  factory Boleto.fromMap(Map<String, dynamic> map) {
    return Boleto(
      name: map['name'] as String,
      dueDate: map['dueDate'] as String,
      price: map['price'] as double,
      barCode: map['barCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Boleto.fromJson(String source) => Boleto.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

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
