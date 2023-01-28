import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DiscountTicket {
  final int id;
  final int percent;
  final double? minAmount;
  final DateTime startAt;
  final DateTime endAt;

  DiscountTicket({
    required this.id,
    required this.percent,
    this.minAmount,
    required this.startAt,
    required this.endAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'percent': percent,
      'min_amount': minAmount,
      'start_at': startAt.toString(),
      'end_at': endAt.toString(),
    };
  }

  factory DiscountTicket.fromMap(Map<String, dynamic> map) {
    return DiscountTicket(
      id: map['id'] as int,
      percent: map['percent'] as int,
      minAmount: map['min_amount'] != null ? map['min_amount'] as double : null,
      startAt: DateTime.parse(map['start_at'] as String),
      endAt: DateTime.parse(map['end_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscountTicket.fromJson(String source) =>
      DiscountTicket.fromMap(json.decode(source) as Map<String, dynamic>);
}
