import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient
      ..baseUrl = dotenv.get('CHATBOT_DOMAIN')
      ..defaultContentType = 'application/json'
      ..timeout = const Duration(seconds: 30);
  }
}
