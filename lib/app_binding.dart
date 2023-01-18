import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/repositories/auth_repository.dart';
import 'package:fashion_shopping_app/core/repositories/cart_repository.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:fashion_shopping_app/core/repositories/user_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider(), permanent: true);
    Get.put(AuthRepository(apiProvider: Get.find()), permanent: true);
    Get.put(CartRepository(apiProvider: Get.find()), permanent: true);
    Get.put(ProductRepository(apiProvider: Get.find()), permanent: true);
    Get.put(UserRepository(apiProvider: Get.find()), permanent: true);
  }
}
