import 'package:fashion_shopping_app/modules/order_detail/order_detail_controller.dart';
import 'package:get/get.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController(
          orderRepository: Get.find(),
          addressRepository: Get.find(),
        ));
  }
}
