import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(authRepository: Get.find()));
  }
}
