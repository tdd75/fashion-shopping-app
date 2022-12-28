import 'package:fashion_shopping_app/modules/home/data/model/product_type.dart';

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      types: json['types']
          .map<ProductType>((res) => ProductType.fromJson(res))
          .toList(),
      rating: json['rating'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      quantity: json['quantity'],
    );
  }
}
