// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_variant.dart';

class CartItem {
  final int id;
  final int quantity;
  final ProductVariant productVariant;
  final bool isReviewed;

  CartItem({
    required this.id,
    required this.quantity,
    required this.productVariant,
    required this.isReviewed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'product_variant': productVariant.toMap(),
      'is_reviewed': isReviewed,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      productVariant: ProductVariant.fromMap(
          map['product_variant'] as Map<String, dynamic>),
      isReviewed: map['is_reviewed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem copyWith({
    int? id,
    int? quantity,
    ProductVariant? productVariant,
    bool? isReviewed,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      productVariant: productVariant ?? this.productVariant,
      isReviewed: isReviewed ?? this.isReviewed,
    );
  }
}
