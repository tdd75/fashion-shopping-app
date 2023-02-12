import 'package:get/get.dart';

import 'product_detail_controller.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.create(() => ProductDetailController(
          productRepository: Get.find(),
          cartRepository: Get.find(),
          reviewRepository: Get.find(),
        ));
  }
}
