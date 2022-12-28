import 'package:fashion_shopping_app/modules/home/data/model/product.dart';

class ProductState {
  List<Product> productList;

  ProductState({
    this.productList = const [],
  });

  ProductState copyWith({
    List<Product>? productList,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
    );
  }
}
