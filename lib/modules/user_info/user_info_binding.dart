import 'package:fashion_shopping_app/modules/user_info/user_info_controller.dart';
import 'package:get/get.dart';

class UserInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController(
        userRepository: Get.find(), addressRepository: Get.find()));
  }
}
