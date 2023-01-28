import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderCreate {
  final List<int> cartItems;
  final int? address;
  final int? discountTicket;

  OrderCreate({
    required this.cartItems,
    this.address,
    this.discountTicket,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart_items': cartItems,
      'address': address,
      'discount_ticket': discountTicket,
    };
  }

  factory OrderCreate.fromMap(Map<String, dynamic> map) {
    return OrderCreate(
      cartItems: List<int>.from(map['cart_items']),
      address: map['address'] != null ? map['address'] as int : null,
      discountTicket:
          map['discount_ticket'] != null ? map['discount_ticket'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCreate.fromJson(String source) =>
      OrderCreate.fromMap(json.decode(source) as Map<String, dynamic>);
}
