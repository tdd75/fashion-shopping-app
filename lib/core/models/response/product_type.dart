import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductType {
  final int id;
  final String color;
  final String size;
  final int quantity;
  final double price;

  ProductType({
    required this.id,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'size': size,
      'quantity': quantity,
      'price': price,
    };
  }

  factory ProductType.fromMap(Map<String, dynamic> map) {
    return ProductType(
      id: map['id'] as int,
      color: map['color'] as String,
      size: map['size'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductType.fromJson(String source) =>
      ProductType.fromMap(json.decode(source) as Map<String, dynamic>);
}
