// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_type.dart';

class Product {
  final int id;
  final double rating;
  final String name;
  final String image;
  final String description;
  final int stocks;
  final bool isFavorite;
  final List<double> priceRange;
  final List<ProductType> productTypes;

  Product({
    required this.id,
    required this.rating,
    required this.name,
    required this.image,
    required this.description,
    required this.stocks,
    required this.isFavorite,
    required this.priceRange,
    required this.productTypes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rating': rating,
      'name': name,
      'image': image,
      'description': description,
      'stocks': stocks,
      'is_favorite': isFavorite,
      'price_range': priceRange,
      'product_types': productTypes.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      rating: map['rating'] as double,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      stocks: map['stocks'] as int,
      isFavorite: map['is_favorite'] as bool,
      priceRange: List<double>.from(map['price_range']),
      productTypes: List<ProductType>.from(
        map['product_types']
            .map((x) => ProductType.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    int? id,
    double? rating,
    String? name,
    String? image,
    String? description,
    int? stocks,
    bool? isFavorite,
    List<double>? priceRange,
    List<ProductType>? productTypes,
  }) {
    return Product(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      stocks: stocks ?? this.stocks,
      isFavorite: isFavorite ?? this.isFavorite,
      priceRange: priceRange ?? this.priceRange,
      productTypes: productTypes ?? this.productTypes,
    );
  }
}
