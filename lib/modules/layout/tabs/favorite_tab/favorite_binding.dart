import 'package:get/get.dart';

import 'package:fashion_shopping_app/modules/layout/tabs/favorite_tab/favorite_controller.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteController(productRepository: Get.find()));
  }
}
