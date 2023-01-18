import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/list_response.dart';


class CartRepository {
  CartRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<ListResponse<CartItem>?> getList() async {
    final res = await apiProvider.get('/cart-items/?limit=10');
    if (res.status.isOk) {
      return ListResponse<CartItem>.fromMap(res.body, CartItem.fromMap);
    }
    return null;
  }

  Future<CartItem?> get(int id) async {
    final res = await apiProvider.get('/cart-items/$id');
    if (res.status.isOk) {
      return CartItem.fromMap(res.body);
    }
    return null;
  }
}
