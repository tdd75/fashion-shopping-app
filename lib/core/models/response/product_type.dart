// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fashion_shopping_app/core/models/response/product_short.dart';

class ProductType {
  final int id;
  final String color;
  final String size;
  final int stocks;
  final double price;
  final ProductShort? product;

  ProductType({
    required this.id,
    required this.color,
    required this.size,
    required this.stocks,
    required this.price,
    this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'size': size,
      'stocks': stocks,
      'price': price,
      'product': product?.toMap(),
    };
  }

  factory ProductType.fromMap(Map<String, dynamic> map) {
    return ProductType(
      id: map['id'] as int,
      color: map['color'] as String,
      size: map['size'] as String,
      stocks: map['stocks'] as int,
      price: map['price'] as double,
      product: map['product'] != null
          ? ProductShort.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductType.fromJson(String source) =>
      ProductType.fromMap(json.decode(source) as Map<String, dynamic>);
}
