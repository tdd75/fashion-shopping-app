import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/order_detail/order_detail_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/helpers/notify.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  List<CartItem>? get cartItems => controller.cartItems;
  Address? get address => controller.address.value;
  DiscountTicket? get discountTicket => controller.discountTicket.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          title: Text(controller.id != null ? 'Order Detail' : 'Checkout'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildAddress(),
              const SizedBox(height: 12),
              const BaseText(
                'Items',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              Divider(color: ColorConstants.darkGray, thickness: 1),
              _buildOrderItemList(),
              const SizedBox(height: 24),
              _buildDiscountTicket(),
              const SizedBox(height: 24),
              _buildOrderDetails(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: BaseButton(
            text: 'Pay now',
            onPressed: () async {
              if (address == null) {
                Notify.warning('Please add delivery address');
                return;
              }
              final result = await controller.createOrder();
              if (result == true) {
                Get.back();
                Notify.success('Order created successfully');
              }
            },
          ),
        ),
      );
    });
  }

  Widget _buildAddress() {
    return InkWell(
      onTap: () => Get.toNamed(Routes.address),
      child: Container(
        color: ColorConstants.lightGray,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: Icon(Icons.location_on, color: ColorConstants.primary),
          title: const BaseText(
            'Delivery Address',
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          subtitle: address != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    BaseText('${address!.fullName} | ${address!.phone}'),
                    BaseText(address!.detail),
                    BaseText(
                      '${address!.ward}, ${address!.district}, ${address!.city}',
                    ),
                  ],
                )
              : const BaseText('Add new address'),
        ),
      ),
    );
  }

  Widget _buildOrderItemList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems!.length,
      itemBuilder: (context, index) => _buildOrderItem(cartItems![index]),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  Widget _buildOrderItem(CartItem cartItem) {
    final productType = cartItem.productType;
    final product = productType.product;
    return ListTile(
      leading: CachedNetworkImage(imageUrl: product!.image),
      title: BaseText(product.name, fontSize: 14),
      subtitle: Wrap(
        direction: Axis.vertical,
        children: [
          BaseText(
            '${productType.color} - ${productType.size}',
            fontSize: 12,
          ),
        ],
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.vertical,
        spacing: 8,
        children: [
          BaseCurrencyText(
            productType.price,
            color: ColorConstants.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          BaseText('x${cartItem.quantity}', fontSize: 12),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseText('Bill Details', fontSize: 14),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText('Subtotal'),
                    BaseCurrencyText(
                      controller.subtotal,
                      color: ColorConstants.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                if (controller.discount != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText('Discount', color: ColorConstants.red),
                      Wrap(
                        spacing: 4,
                        children: [
                          BaseText(
                            '-',
                            color: ColorConstants.red,
                            fontWeight: FontWeight.w400,
                          ),
                          BaseCurrencyText(
                            controller.discount!,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ),
          const Divider(thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BaseText('Amount', fontSize: 16),
              if (controller.amount != null)
                BaseCurrencyText(
                  controller.amount!,
                  color: ColorConstants.black,
                ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDiscountTicket() {
    return InkWell(
      onTap: () => Get.toNamed(Routes.discountTicket),
      child: Container(
        color: ColorConstants.lightGray,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BaseText(
              'Select discount ticket',
              fontSize: 14,
              color: Colors.black54,
            ),
            discountTicket != null
                ? Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.warning,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: BaseText(
                      '-${discountTicket!.percent}%',
                      fontSize: 14,
                    ),
                  )
                : const Icon(
                    Icons.chevron_right,
                    color: Colors.black54,
                  ),
          ],
        ),
      ),
    );
  }
}
