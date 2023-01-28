// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartCreate {
  final int quantity;
  final int productTypeId;

  CartCreate({
    required this.quantity,
    required this.productTypeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'product_type': productTypeId,
    };
  }

  factory CartCreate.fromMap(Map<String, dynamic> map) {
    return CartCreate(
      quantity: map['quantity'] as int,
      productTypeId: map['product_type'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartCreate.fromJson(String source) =>
      CartCreate.fromMap(json.decode(source) as Map<String, dynamic>);
}
