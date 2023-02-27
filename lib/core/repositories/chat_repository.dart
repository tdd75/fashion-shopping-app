import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/common/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/admin_info.dart';
import 'package:fashion_shopping_app/core/models/response/bot_message.dart';
import 'package:fashion_shopping_app/core/models/response/message.dart';
import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:fashion_shopping_app/shared/helpers/query_string.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  final ApiProvider apiProvider = Get.find();

  Future<AdminInfo?> getAdminInfo() async {
    final res = await apiProvider.get('/chat/admin-info');
    return res.status.isOk ? AdminInfo.fromMap(res.body) : null;
  }

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

  Future<List<BotMessage>?> sendMessage(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final res = await apiProvider.post(
        '/chat/chatbot/',
        json.encode({
          'message': message,
          'init_chatbot_at': prefs.getString(StorageKey.initChatbotAt)
        }));
    return res.status.isOk
        ? List.from(res.body.map((data) => BotMessage.fromMap(data)))
        : null;
  }
}
