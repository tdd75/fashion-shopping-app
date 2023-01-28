// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductShort {
  final int id;
  final String name;
  final String image;
  final double rating;
  final List<double> priceRange;

  ProductShort({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.priceRange,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'price_range': priceRange,
    };
  }

  factory ProductShort.fromMap(Map<String, dynamic> map) {
    return ProductShort(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      rating: map['rating'] as double,
      priceRange: List<double>.from((map['price_range'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductShort.fromJson(String source) =>
      ProductShort.fromMap(json.decode(source) as Map<String, dynamic>);
}
