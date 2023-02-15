import 'package:fashion_shopping_app/core/models/request/message_create.dart';
import 'package:fashion_shopping_app/core/models/response/admin_info.dart';
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
  var messages = Rx<List<Message>>([]);
  var adminInfo = Rxn<AdminInfo>();

  final textController = TextEditingController();
  final focusNode = FocusNode();
  WebSocketChannel? channel;

  @override
  void onInit() async {
    isLoading.value = true;

    super.onInit();

    await fetchAdminInfo();
    _connectSocket();
    channel!.stream.listen((message) {
      final data = Message.fromJson(message);
      messages.value.insert(0, data);
      messages.refresh();
    }, onError: (e) async {
      await Future.delayed(const Duration(seconds: 5));
      _connectSocket();
    });
    await fetchMessages();
    isLoading.value = false;
  }

  void _connectSocket() {
    channel = WebSocketChannel.connect(Uri.parse(
        '${dotenv.get('WS_DOMAIN')}/msg/?token=${Get.find<SharedPreferences>().getString('access')}&receiver=${adminInfo.value!.id}'));
  }

  Future<void> fetchMessages() async {
    final response = await chatRepository.getList();
    if (response != null) {
      messages.value = response.results;
    }
  }

  Future<void> fetchAdminInfo() async {
    final response = await chatRepository.getAdminInfo();
    if (response != null) {
      adminInfo.value = response;
    }
  }

  void sendMessage(MessageCreate data) {
    channel!.sink.add(data.toJson());
  }
}
