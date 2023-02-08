// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/shared/enums/payment_method.dart';

class Order {
  final int id;
  final String code;
  final List<CartItem> orderItems;
  final Address? address;
  final double subtotal;
  final double? discount;
  final double amount;
  final String stage;
  final PaymentMethod paymentMethod;
  final DateTime? paidAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.code,
    required this.orderItems,
    required this.address,
    required this.subtotal,
    this.discount,
    required this.amount,
    required this.stage,
    required this.paymentMethod,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_items': orderItems.map((x) => x.toMap()).toList(),
      'address': address,
      'subtotal': subtotal,
      'discount': discount,
      'amount': amount,
      'code': code,
      'stage': stage,
      'pagement_method': paymentMethod.value,
      'paid_at': paidAt?.toString(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      orderItems: List<CartItem>.from(map['order_items']
          .map((x) => CartItem.fromMap(x as Map<String, dynamic>))),
      address: map['address'] is Map ? Address.fromMap(map['address']) : null,
      subtotal: map['subtotal'] as double,
      discount: map['discount'] != null ? map['discount'] as double : null,
      amount: map['amount'] as double,
      code: map['code'] as String,
      stage: map['stage'] as String,
      paymentMethod: PaymentMethod.fromString(map['payment_method'] as String)!,
      paidAt: map['paid_at'] != null
          ? DateTime.parse(map['paid_at'] as String)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
