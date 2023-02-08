// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductFavoriteUpdate {
  final bool isFavorite;

  ProductFavoriteUpdate({
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_favorite': isFavorite,
    };
  }

  factory ProductFavoriteUpdate.fromMap(Map<String, dynamic> map) {
    return ProductFavoriteUpdate(
      isFavorite: map['is_favorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductFavoriteUpdate.fromJson(String source) =>
      ProductFavoriteUpdate.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
