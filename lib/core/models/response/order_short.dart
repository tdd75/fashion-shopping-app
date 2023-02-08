// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/shared/enums/payment_method.dart';

class OrderShort {
  final int id;
  final String code;
  final PaymentMethod paymentMethod;

  OrderShort({
    required this.id,
    required this.code,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'pagement_method': paymentMethod.value,
    };
  }

  factory OrderShort.fromMap(Map<String, dynamic> map) {
    return OrderShort(
      id: map['id'] as int,
      code: map['code'] as String,
      paymentMethod: PaymentMethod.fromString(map['payment_method'] as String)!,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderShort.fromJson(String source) =>
      OrderShort.fromMap(json.decode(source) as Map<String, dynamic>);
}
