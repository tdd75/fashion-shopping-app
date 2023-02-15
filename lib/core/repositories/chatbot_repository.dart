import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/chatbot_api_provider.dart';
import 'package:fashion_shopping_app/core/models/response/bot_message.dart';
import 'package:get/get.dart';

class ChatbotRepository {
  final ChatbotApiProvider chatbotApiProvider = Get.find();

  Future<List<BotMessage>?> sendMessage(String message) async {
    final res =
        await chatbotApiProvider.post('/', json.encode({'message': message}));
    return res.status.isOk
        ? List.from(res.body.map((data) => BotMessage.fromMap(data)))
        : null;
  }
}
