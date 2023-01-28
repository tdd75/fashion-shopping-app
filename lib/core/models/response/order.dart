// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Order {
  final int id;
  final double amount;
  final String code;
  final String stage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.amount,
    required this.code,
    required this.stage,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'code': code,
      'stage': stage,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      amount: map['amount'] as double,
      code: map['code'] as String,
      stage: map['stage'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
