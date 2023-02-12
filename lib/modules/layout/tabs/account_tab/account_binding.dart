import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:get/get.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController(
        userRepository: Get.find(), addressRepository: Get.find()));
  }
}
