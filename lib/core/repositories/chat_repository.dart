import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/message.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:get/get.dart';

class ChatRepository {
  final ApiProvider apiProvider = Get.find();

  Future<ListResponse<Message>?> getList(
      {Map<String, dynamic> params = const {}}) async {
    final query = {
      'expand': 'sender,receiver',
      ...params,
    };
    final res =
        await apiProvider.get('/chat/', query: QueryString.convert(query));
    return res.status.isOk
        ? ListResponse<Message>.fromMap(res.body, Message.fromMap)
        : null;
  }

  // Future<Address?> send(int id) async {
  //   final res = await apiProvider.get('/addresses/$id/');
  //   return res.status.isOk ? Address.fromMap(res.body) : null;
  // }
}
