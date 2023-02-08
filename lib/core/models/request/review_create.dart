// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewCreate {
  final int variant;
  final int order;
  final String content;
  final double rating;

  ReviewCreate({
    required this.variant,
    required this.order,
    required this.content,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'variant': variant,
      'order': order,
      'content': content,
      'rating': rating,
    };
  }

  factory ReviewCreate.fromMap(Map<String, dynamic> map) {
    return ReviewCreate(
      variant: map['variant'] as int,
      order: map['order'] as int,
      content: map['content'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewCreate.fromJson(String source) =>
      ReviewCreate.fromMap(json.decode(source) as Map<String, dynamic>);
}
