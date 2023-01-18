import 'package:get/get.dart';

import 'cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => CartController(cartRepository: Get.find()));
  }
}
