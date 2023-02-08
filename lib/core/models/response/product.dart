// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_variant.dart';

class Product {
  final int id;
  final String name;
  final String image;
  final String description;
  final double rating;
  final int reviewCount;
  final int stocks;
  final bool isFavorite;
  final List<double> priceRange;
  final List<ProductVariant> productVariants;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.stocks,
    required this.isFavorite,
    required this.priceRange,
    required this.productVariants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'rating': rating,
      'review_count': reviewCount,
      'stocks': stocks,
      'is_favorite': isFavorite,
      'price_range': priceRange,
      'product_variants': productVariants.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      rating: map['rating'] as double,
      reviewCount: map['review_count'] as int,
      stocks: map['stocks'] as int,
      isFavorite: map['is_favorite'] as bool,
      priceRange: List<double>.from(map['price_range']),
      productVariants: List<ProductVariant>.from(
        map['variants']
            .map((x) => ProductVariant.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    double? rating,
    int? reviewCount,
    int? stocks,
    bool? isFavorite,
    List<double>? priceRange,
    List<ProductVariant>? productVariants,
  }) {
    return Product(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      name: name ?? this.name,
      image: image ?? this.image,
      reviewCount: reviewCount ?? this.reviewCount,
      description: description ?? this.description,
      stocks: stocks ?? this.stocks,
      isFavorite: isFavorite ?? this.isFavorite,
      priceRange: priceRange ?? this.priceRange,
      productVariants: productVariants ?? this.productVariants,
    );
  }
}
