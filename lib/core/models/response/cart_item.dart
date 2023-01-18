// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_type.dart';


class CartItem {
  final int id;
  final double amount;
  final int quantity;
  final double size;
  final String color;
  final String image;
  final double price;
  final ProductType type;

  CartItem({
    required this.id,
    required this.amount,
    required this.quantity,
    required this.size,
    required this.color,
    required this.image,
    required this.price,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'quantity': quantity,
      'size': size,
      'color': color,
      'image': image,
      'price': price,
      'type': type.toMap(),
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int,
      amount: map['amount'] as double,
      quantity: map['quantity'] as int,
      size: map['size'] as double,
      color: map['color'] as String,
      image: map['image'] as String,
      price: map['price'] as double,
      type: ProductType.fromMap(map['type'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
