import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/checkbox/base_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_quantity.dart';
import 'package:fashion_shopping_app/modules/cart/cart_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  List<CartItem> get cartItems => controller.cartItems.value;
  List<bool> get selectedIndexes => controller.selectedIndexes.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(title: const Text('Cart'), elevation: 0),
        body: cartItems.isEmpty
            ? const NoItem()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: cartItems.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    _buildCartItem(index),
                    const Divider(thickness: 1.5),
                  ],
                ),
              ),
        bottomSheet: controller.selectedCartItems.isNotEmpty
            ? _buildBillDetails()
            : null,
      );
    });
  }

  Widget _buildCartItem(int index) {
    final productType = cartItems[index].productType;
    final product = productType.product!;
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => controller.deleteCartItem(index),
            backgroundColor: ColorConstants.error,
            foregroundColor: ColorConstants.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        onTap: () => Get.toNamed(Routes.productDetail, arguments: product.id),
        leading: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            BaseCheckbox(
              checked: selectedIndexes[index],
              onChecked: (value) =>
                  controller.toggleSelectCartItem(index, value!),
            ),
            // CachedNetworkImage(
            //   height: 56,
            //   fit: BoxFit.fill,
            //   imageUrl: product.image,
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // ),
          ],
        ),
        title: BaseText(
          product.name,
          fontWeight: FontWeight.w500,
        ),
        subtitle: Wrap(
          direction: Axis.vertical,
          spacing: 4,
          children: [
            Text('${productType.color} - ${productType.size}'),
            BaseCurrencyText(productType.price, fontSize: 14),
          ],
        ),
        trailing: BaseInputQuantity(
          controller: controller.quantityControllers[index],
          onChanged: (value) => controller.updateQuantity(index, value),
          maxValue: cartItems[index].productType.stocks,
        ),
      ),
    );
  }

  Widget _buildBillDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 2,
            direction: Axis.vertical,
            children: [
              const BaseText('Total', fontSize: 14, color: Colors.black54),
              BaseCurrencyText(
                controller.totalPrice,
                color: ColorConstants.black,
              ),
            ],
          ),
          const SizedBox(width: 12),
          BaseButton(
            width: 128,
            text: 'Checkout',
            onPressed: () {
              Get.toNamed(
                Routes.orderDetail,
                arguments: {
                  'cartItems': controller.selectedCartItems,
                  'totalPrice': controller.totalPrice,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
