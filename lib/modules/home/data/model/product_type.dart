class ProductType {
  final int id;
  final String color;
  final String size;
  final int quantity;
  final double price;

  ProductType({
    required this.id,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      color: json['color'],
      size: json['size'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
