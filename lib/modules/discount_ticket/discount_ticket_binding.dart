import 'package:get/get.dart';

import 'package:fashion_shopping_app/modules/discount_ticket/discount_ticket_controller.dart';

class DiscountTicketBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => DiscountTicketController(discountTicketRepository: Get.find()));
  }
}
