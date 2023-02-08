import 'dart:convert';

import 'package:fashion_shopping_app/shared/enums/payment_method.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderCreate {
  final List<int> orderItems;
  final int address;
  final int? discountTicket;
  final PaymentMethod paymentMethod;

  OrderCreate({
    required this.orderItems,
    required this.address,
    this.discountTicket,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_items': orderItems,
      'address': address,
      'discount_ticket': discountTicket,
      'payment_method': paymentMethod.value,
    };
  }

  factory OrderCreate.fromMap(Map<String, dynamic> map) {
    return OrderCreate(
      orderItems: List<int>.from(map['order_items']),
      address: map['address'] as int,
      discountTicket:
          map['discount_ticket'] != null ? map['discount_ticket'] as int : null,
      paymentMethod: PaymentMethod.fromString(map['payment_method'] as String)!,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCreate.fromJson(String source) =>
      OrderCreate.fromMap(json.decode(source) as Map<String, dynamic>);
}
