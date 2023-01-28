import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/cart_create.dart';
import 'package:fashion_shopping_app/core/models/request/cart_update.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:get/get.dart';

class CartRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<CartItem>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {
      'expand': 'product_type,product_type.product',
      ...params,
    };
    final res =
        await apiProvider.get('/cart/', query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<CartItem>.fromMap(res.body, CartItem.fromMap)
        : null;
  }

  Future<CartItem?> get(int id) async {
    final res = await apiProvider.get('/cart/$id/');
    return res.status.isOk ? CartItem.fromMap(res.body) : null;
  }

  Future<bool> create(CartCreate data) async {
    final res = await apiProvider.post('/cart/', data.toJson());
    return res.status.isOk;
  }

  Future<bool> update(int id, CartUpdate data) async {
    final res = await apiProvider.patch('/cart/$id/', data.toJson());
    return res.status.isOk;
  }

  Future<bool> delete(int id) async {
    final res = await apiProvider.delete('/cart/$id/');
    return res.status.isOk;
  }
}
