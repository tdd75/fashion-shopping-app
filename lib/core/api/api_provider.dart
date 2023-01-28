import 'package:fashion_shopping_app/core/api/interceptors/auth_interceptor.dart';
import 'package:fashion_shopping_app/core/api/interceptors/request_interceptor.dart';
import 'package:fashion_shopping_app/core/api/interceptors/response_interceptor.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient
      ..baseUrl = dotenv.get('DOMAIN')
      ..defaultContentType = "application/json"
      ..addAuthenticator(authInterceptor)
      ..addRequestModifier(requestInterceptor)
      ..addResponseModifier(responseInterceptor)
      ..timeout = const Duration(seconds: 30);
  }
}
