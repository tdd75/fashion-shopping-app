import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/order_create.dart';
import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:get/get.dart';

class OrderRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<Order>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {...params};
    final res = await apiProvider.get('/orders/', query: query);
    return res.status.isOk
        ? ListResponse<Order>.fromMap(res.body, Order.fromMap)
        : null;
  }

  Future<Order?> get(int id) async {
    final res = await apiProvider.get('/orders/$id/');
    return res.status.isOk ? Order.fromMap(res.body) : null;
  }

  Future<bool> create(OrderCreate data) async {
    final res = await apiProvider.post('/orders/', data.toJson());
    return res.status.isOk;
  }
}
