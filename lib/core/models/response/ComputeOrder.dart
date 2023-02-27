import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComputeOrder {
  final double subtotal;
  final double discount;
  final double amount;

  ComputeOrder({
    required this.subtotal,
    required this.discount,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subtotal': subtotal,
      'discount': discount,
      'amount': amount,
    };
  }

  factory ComputeOrder.fromMap(Map<String, dynamic> map) {
    return ComputeOrder(
      subtotal: map['subtotal'] as double,
      discount: map['discount'] as double,
      amount: map['amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComputeOrder.fromJson(String source) =>
      ComputeOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}
