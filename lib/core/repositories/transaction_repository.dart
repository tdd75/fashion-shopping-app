import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:get/get.dart';

class TransactionRepository {
  final ApiProvider apiProvider = Get.find();

  Future<String?> create(int orderId) async {
    final res = await apiProvider.post(
        '/transactions/', json.encode({'order': orderId}));
    return res.status.isOk ? res.body['payment_link'] : null;
  }
}
