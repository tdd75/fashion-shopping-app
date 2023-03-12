import 'package:fashion_shopping_app/core/models/request/cart_update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/repositories/cart_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;

  CartController({required this.cartRepository});

  var isLoading = false.obs;
  var cartItems = Rx<List<CartItem>>([]);

  List<TextEditingController> quantityControllers = [];
  final selectedIndexes = Rx<List<bool>>([]);

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    if (Get.find<SharedPreferences>().containsKey('access')) {
      await fetchCartItems();
    }
    isLoading.value = false;
  }

  void initListController() {
    quantityControllers = cartItems.value
        .map((e) => TextEditingController(text: e.quantity.toString()))
        .toList();
    selectedIndexes.value = List.filled(cartItems.value.length, false);
  }

  int getId(int index) {
    return cartItems.value[index].id;
  }

  List<CartItem> get selectedCartItems {
    return cartItems.value
        .asMap()
        .entries
        .where((element) => selectedIndexes.value[element.key])
        .map((e) => e.value)
        .toList();
  }

  double get totalPrice {
    return selectedCartItems
        .map((e) => e.productVariant.price * e.quantity)
        .fold<double>(0, (p, c) => p + c)
        .toPrecision(2);
  }

  void toggleSelectCartItem(int index, bool status) {
    selectedIndexes.value[index] = status;
    selectedIndexes.refresh();
  }

  Future<void> fetchCartItems() async {
    final response = await cartRepository.getList();
    if (response != null) {
      cartItems.value = response.results;
      initListController();
    }
  }

  Future<void> updateQuantity(int index, int quantity) async {
    cartItems.value[index] =
        cartItems.value[index].copyWith(quantity: quantity);
    cartItems.refresh();
    await cartRepository.update(getId(index), CartUpdate(quantity: quantity));
  }

  Future<void> deleteCartItem(int index) async {
    final isDeleted = await cartRepository.delete(getId(index));
    if (isDeleted) {
      cartItems.value.removeAt(index);
      quantityControllers.removeAt(index);
      cartItems.refresh();
    }
  }
}
