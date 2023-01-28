// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_type.dart';

class CartItem {
  final int id;
  final int quantity;
  final ProductType productType;

  CartItem({
    required this.id,
    required this.quantity,
    required this.productType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'product_type': productType.toMap(),
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      productType:
          ProductType.fromMap(map['product_type'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem copyWith({
    int? id,
    int? quantity,
    ProductType? productType,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      productType: productType ?? this.productType,
    );
  }
}
