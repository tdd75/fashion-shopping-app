import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/product_favorite_update.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/models/response/product_filter.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:get/get.dart';

class ProductRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<ProductShort>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {
      'fields': 'id,name,image,price_range,rating,is_favorite',
      ...params,
    };
    final res =
        await apiProvider.get('/products/', query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<ProductShort>.fromMap(res.body, ProductShort.fromMap)
        : null;
  }

  Future<ListResponse<ProductShort>?> searchByImage(String encodedImage) async {
    final res = await apiProvider.post(
        '/products/search-image/', json.encode({'image': encodedImage}));
    return res.status.isOk
        ? ListResponse<ProductShort>.fromMap(res.body, ProductShort.fromMap)
        : null;
  }

  Future<ListResponse<ProductShort>?> getRelatedProducts(int id) async {
    final res = await apiProvider.get('/products/$id/related-products/');
    return res.status.isOk
        ? ListResponse<ProductShort>.fromMap(res.body, ProductShort.fromMap)
        : null;
  }

  Future<Product?> get(int id) async {
    const query = {'expand': 'variants,variants.product'};
    final res = await apiProvider.get('/products/$id/',
        query: QueryString.convert(query));
    return res.status.isOk ? Product.fromMap(res.body) : null;
  }

  Future<bool> updateFavorite(int id, ProductFavoriteUpdate data) async {
    final res =
        await apiProvider.post('/products/$id/update-favorite/', data.toJson());
    return res.status.isOk;
  }

  Future<ProductFilter?> getFilter() async {
    final res = await apiProvider.get('/products/product-filter/');
    return res.status.isOk ? ProductFilter.fromMap(res.body) : null;
  }
}
