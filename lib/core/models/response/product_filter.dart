// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_category.dart';

class ProductFilter {
  final List<double> priceRange;
  final List<String> colors;
  final List<String> sizes;
  final List<ProductCategory> categories;

  ProductFilter({
    required this.priceRange,
    required this.colors,
    required this.sizes,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price_range': priceRange,
      'colors': colors,
      'sizes': sizes,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductFilter.fromMap(Map<String, dynamic> map) {
    return ProductFilter(
      priceRange: List<double>.from(map['price_range']),
      colors: List<String>.from(map['colors']),
      sizes: List<String>.from(map['sizes']),
      categories: map['categories']
          .map<ProductCategory>(
              (x) => ProductCategory.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductFilter.fromJson(String source) =>
      ProductFilter.fromMap(json.decode(source) as Map<String, dynamic>);
}
