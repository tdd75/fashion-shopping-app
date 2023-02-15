import 'package:fashion_shopping_app/core/models/response/admin_info.dart';
import 'package:fashion_shopping_app/core/models/response/bot_message.dart';
import 'package:fashion_shopping_app/core/repositories/chatbot_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ChatbotRepository chatbotRepository;

  ChatbotController({required this.chatbotRepository});

  var isLoading = false.obs;
  var isComposing = false.obs;
  var messages = Rx<List<BotMessage>>([]);
  var adminInfo = Rxn<AdminInfo>();

  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    isLoading.value = false;
  }

  Future<void> sendMessage(String message) async {
    messages.value.insert(0, BotMessage(text: message, isUser: true));
    messages.refresh();
    final response = await chatbotRepository.sendMessage(message);
    messages.value.insertAll(0, response!.reversed);
    messages.refresh();
  }
}
