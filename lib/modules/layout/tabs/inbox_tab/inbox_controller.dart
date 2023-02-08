import 'package:fashion_shopping_app/core/models/request/message_create.dart';
import 'package:fashion_shopping_app/core/models/response/message.dart';
import 'package:fashion_shopping_app/core/repositories/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InboxController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ChatRepository chatRepository;

  InboxController({required this.chatRepository});

  var isLoading = false.obs;
  var isComposing = false.obs;
  var messages = Rxn<List<Message>>();
  var isSelf = true.obs;

  final textController = TextEditingController();
  final focusNode = FocusNode();
  late WebSocketChannel channel;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    channel = WebSocketChannel.connect(Uri.parse(
        '${dotenv.get('WS_DOMAIN')}/msg/?token=${Get.find<SharedPreferences>().getString('access')}'));
    channel.stream.listen((message) {
      final data = Message.fromJson(message);
      messages.value!.insert(0, data);
      messages.refresh();
    });

    await fetchMessages();

    isLoading.value = false;
  }

  Future<void> fetchMessages() async {
    final response = await chatRepository.getList();
    if (response != null) {
      messages.value = response.results;
    }
  }

  void sendMessage(MessageCreate data) {
    channel.sink.add(data.toJson());
  }
}
