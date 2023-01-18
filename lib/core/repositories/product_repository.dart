import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/helpers/query_string.dart';
import 'package:fashion_shopping_app/core/models/response/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';

class ProductRepository {
  ProductRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<ListResponse<Product>?> getList(Map<String, dynamic> query) async {
    final res =
        await apiProvider.get('/products/', query: QueryString.convert(query));
    if (res.status.isOk) {
      return ListResponse<Product>.fromMap(res.body, Product.fromMap);
    }
    return null;
  }

  Future<Product?> get(int id) async {
    final res = await apiProvider.get('/products/$id');
    if (res.status.isOk) {
      return Product.fromMap(res.body);
    }
    return null;
  }
}
