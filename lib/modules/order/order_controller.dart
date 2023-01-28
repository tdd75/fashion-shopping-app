import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepository orderRepository;

  OrderController({required this.orderRepository});

  var isLoading = false.obs;
  var cartItems = Rx<List<Order>>([]);

  late List<TextEditingController> quantityControllers;
  final selectedCartItems = Rx<List<bool>>([]);

  int getId(int index) {
    return cartItems.value[index].id;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchOrders();
    isLoading.value = false;
  }

  void toggleSelectCartItem(int index, bool status) {
    selectedCartItems.value[index] = status;
    selectedCartItems.refresh();
  }

  Future<void> fetchOrders() async {
    final response = await orderRepository.getList();
    if (response != null) {
      cartItems.value = response.results;
    }
  }
}
