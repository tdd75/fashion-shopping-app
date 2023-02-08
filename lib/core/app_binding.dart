import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:fashion_shopping_app/core/repositories/review_repository.dart';
import 'package:fashion_shopping_app/core/repositories/transaction_repository.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/repositories/auth_repository.dart';
import 'package:fashion_shopping_app/core/repositories/cart_repository.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:fashion_shopping_app/core/repositories/user_repository.dart';
import 'package:fashion_shopping_app/core/repositories/order_repository.dart';
import 'package:fashion_shopping_app/core/repositories/chat_repository.dart';
import 'package:fashion_shopping_app/core/repositories/discount_ticket_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(AuthRepository(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(ProductRepository(), permanent: true);
    Get.put(OrderRepository(), permanent: true);
    Get.put(TransactionRepository(), permanent: true);
    Get.put(AddressRepository(), permanent: true);
    Get.put(DiscountTicketRepository(), permanent: true);
    Get.put(ChatRepository(), permanent: true);
    Get.put(ReviewRepository(), permanent: true);
  }
}
