// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartUpdate {
  final int quantity;

  CartUpdate({
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
    };
  }

  factory CartUpdate.fromMap(Map<String, dynamic> map) {
    return CartUpdate(
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartUpdate.fromJson(String source) =>
      CartUpdate.fromMap(json.decode(source) as Map<String, dynamic>);
}
