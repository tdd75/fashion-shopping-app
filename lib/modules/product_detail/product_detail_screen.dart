import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/core/widgets/icon/base_badge_icon.dart';
import 'package:fashion_shopping_app/modules/product_detail/product_detail_controller.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
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
      body: Obx(() => Text(controller.product.value?.name ?? 'No prpduc')),
    );
  }
}
