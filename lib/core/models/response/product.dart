// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_type.dart';

class Product {
  final int id;
  final List<ProductType> types;
  final double rating;
  final String name;
  final String image;
  final String description;
  final int quantity;

  Product({
    required this.id,
    required this.types,
    required this.rating,
    required this.name,
    required this.image,
    required this.description,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'types': List<ProductType>.from(types.map((x) => x.toMap())),
      'rating': rating,
      'name': name,
      'image': image,
      'description': description,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      types: List<ProductType>.from(map['types'].map(
        (x) => ProductType.fromMap(x),
      )),
      rating: map['rating'] as double,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
