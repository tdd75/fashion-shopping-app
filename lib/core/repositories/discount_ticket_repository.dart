import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:get/get.dart';

class DiscountTicketRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<DiscountTicket>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {...params};
    final res = await apiProvider.get('/discount-tickets/',
        query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<DiscountTicket>.fromMap(res.body, DiscountTicket.fromMap)
        : null;
  }

  Future<bool> saveTicket(int id) async {
    final res =
        await apiProvider.post('/discount-tickets/$id/save-ticket/', null);
    return res.status.isOk;
  }
}
