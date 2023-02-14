import 'package:fashion_shopping_app/modules/layout/tabs/chatbot_tab/chatbot_controller.dart';
import 'package:get/get.dart';

class ChatbotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatbotController(chatRepository: Get.find()));
  }
}
