import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/core/widgets/icon/base_badge_icon.dart';
import 'package:fashion_shopping_app/modules/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          BaseBadgeIcon(
            number: 1,
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              Get.toNamed(Routes.cart);
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
