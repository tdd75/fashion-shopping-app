import 'package:fashion_shopping_app/modules/checkout/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController(
          orderRepository: Get.find(),
          addressRepository: Get.find(),
          discountTicketRepository: Get.find(),
          transactionRepository: Get.find(),
        ));
  }
}
