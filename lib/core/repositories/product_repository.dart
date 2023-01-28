import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/product_update_favorite.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:get/get.dart';

class ProductRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<ProductShort>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {
      'fields': 'id,name,image,price_range,rating',
      ...params,
    };
    final res =
        await apiProvider.get('/products/', query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<ProductShort>.fromMap(res.body, ProductShort.fromMap)
        : null;
  }

  Future<Product?> get(int id) async {
    const query = {'expand': 'product_types,product_types.product'};
    final res = await apiProvider.get('/products/$id/',
        query: QueryString.convert(query));
    return res.status.isOk ? Product.fromMap(res.body) : null;
  }

  Future<bool> updateFavorite(int id, ProductUpdateFavorite data) async {
    final res =
        await apiProvider.post('/products/$id/update-favorite/', data.toJson());
    return res.status.isOk;
  }
}
