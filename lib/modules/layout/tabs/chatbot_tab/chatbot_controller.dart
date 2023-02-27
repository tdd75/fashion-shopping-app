import 'package:fashion_shopping_app/core/models/response/admin_info.dart';
import 'package:fashion_shopping_app/core/models/response/bot_message.dart';
import 'package:fashion_shopping_app/core/repositories/chat_repository.dart';
import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ChatRepository chatRepository;

  ChatbotController({required this.chatRepository});

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
    if (messages.value.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        StorageKey.initChatbotAt,
        DateTime.now().toString(),
      );
    }
    if (message.trim().isEmpty) return;
    messages.value.insert(0, BotMessage(text: message, isUser: true));
    messages.refresh();
    final response = await chatRepository.sendMessage(message);
    if (response != null) {
      messages.value.insertAll(0, response.reversed);
      messages.refresh();
    }
  }
}
