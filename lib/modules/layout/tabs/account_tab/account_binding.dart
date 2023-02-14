import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:get/get.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AccountController(authRepository: Get.find()));
  }
}
