import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/order_create.dart';
import 'package:fashion_shopping_app/core/models/response/ComputeOrder.dart';
import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/order_short.dart';
import 'package:get/get.dart';

class OrderRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<Order>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {
      'expand':
          'order_items,order_items.product_variant,order_items.product_variant.product',
      ...params
    };
    final res = await apiProvider.get('/orders/', query: query);
    return res.status.isOk
        ? ListResponse<Order>.fromMap(res.body, Order.fromMap)
        : null;
  }

  Future<Order?> get(int id) async {
    final query = {
      'expand':
          'address,order_items,order_items.product_variant,order_items.product_variant.product',
    };
    final res = await apiProvider.get('/orders/$id/', query: query);
    return res.status.isOk ? Order.fromMap(res.body) : null;
  }

  Future<OrderShort?> create(OrderCreate data) async {
    final res = await apiProvider.post('/orders/', data.toJson());
    return res.status.isOk ? OrderShort.fromMap(res.body) : null;
  }

  Future<bool?> cancelOrder(int id) async {
    final res = await apiProvider.post('/orders/$id/cancel/', null);
    return res.status.isOk;
  }

  Future<bool?> confirmReceived(int id) async {
    final res = await apiProvider.post('/orders/$id/confirm-received/', null);
    return res.status.isOk;
  }

  Future<ComputeOrder?> computeOrder(
      List<int> cartItemIds, int? discountTicketId) async {
    final data = {
      'cart_items': cartItemIds,
      'discount_ticket': discountTicketId,
    };
    final res =
        await apiProvider.post('/orders/compute-order/', json.encode(data));
    return res.status.isOk ? ComputeOrder.fromMap(res.body) : null;
  }
}
