// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_variant.dart';
import 'package:fashion_shopping_app/core/models/response/user_short.dart';

class Review {
  final int id;
  final ProductVariant variant;
  final String content;
  final String rating;
  final UserShort owner;

  Review({
    required this.id,
    required this.variant,
    required this.content,
    required this.rating,
    required this.owner,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': variant.toMap(),
      'content': content,
      'rating': rating,
      'owner': owner.toMap(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as int,
      variant: ProductVariant.fromMap(map['variant'] as Map<String, dynamic>),
      content: map['content'] as String,
      rating: map['rating'] as String,
      owner: UserShort.fromMap(map['owner'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
