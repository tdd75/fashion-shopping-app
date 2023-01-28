// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductUpdateFavorite {
  final bool isFavorite;

  ProductUpdateFavorite({
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_favorite': isFavorite,
    };
  }

  factory ProductUpdateFavorite.fromMap(Map<String, dynamic> map) {
    return ProductUpdateFavorite(
      isFavorite: map['is_favorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUpdateFavorite.fromJson(String source) =>
      ProductUpdateFavorite.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
