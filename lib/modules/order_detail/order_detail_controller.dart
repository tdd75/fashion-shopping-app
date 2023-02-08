import 'package:fashion_shopping_app/core/models/request/review_create.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/repositories/review_repository.dart';
import 'package:fashion_shopping_app/core/repositories/transaction_repository.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/repositories/order_repository.dart';

class OrderDetailController extends GetxController {
  final OrderRepository orderRepository;
  final TransactionRepository transactionRepository;
  final ReviewRepository reviewRepository;

  OrderDetailController({
    required this.orderRepository,
    required this.transactionRepository,
    required this.reviewRepository,
  });

  var isLoading = false.obs;
  var order = Rxn<Order>();

  List<CartItem> get notReviewedItems {
    return order.value!.orderItems
        .where((element) => !element.isReviewed)
        .toList();
  }

  late int id;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    id = Get.arguments;
    await fetchOrder();
    isLoading.value = false;
  }

  Future<void> fetchOrder() async {
    final response = await orderRepository.get(id);
    if (response != null) {
      order.value = response;
      order.refresh();
    }
  }

  Future<void> submitReviews(
      int variantId, String content, double rating) async {
    await reviewRepository.create(ReviewCreate(
      variant: variantId,
      order: order.value!.id,
      content: content,
      rating: rating,
    ));
  }
}
