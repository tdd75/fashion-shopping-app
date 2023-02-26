import 'package:fashion_shopping_app/modules/cart/cart_controller.dart';
import 'package:fashion_shopping_app/shared/enums/payment_method.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/shared/widgets/order/order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/checkout/checkout_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

import 'order_success_screen.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  List<CartItem> get cartItems => controller.cartItems;
  Address? get address => controller.address.value;
  DiscountTicket? get discountTicket => controller.selectedDiscountTicket.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddress(),
              const SizedBox(height: 12),
              _buildOrderItemList(),
              const SizedBox(height: 12),
              _buildDiscountTicket(),
              const SizedBox(height: 12),
              _buildPaymentMethod(),
              const SizedBox(height: 12),
              _buildOrderReview(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: BaseButton(
            text: 'Purchase',
            onPressed: () async {
              if (address == null) {
                Notify.warning('Please add delivery address');
                return;
              }
              final response = await controller.createOrder();
              if (response != null) {
                Get.find<CartController>().fetchCartItems();
                Get.off(OrderSuccessScreen(
                  orderId: response.id,
                  orderCode: response.code,
                ));
                // create transaction if payment method is not COD
                if (response.paymentMethod != PaymentMethod.cod) {
                  final paymentLink = await controller.transactionRepository
                      .create(response.id);
                  if (paymentLink != null) {
                    final paymentUri = Uri.parse(paymentLink);
                    if (await canLaunchUrl(paymentUri)) {
                      launchUrl(paymentUri);
                    }
                  }
                }
              }
            },
          ),
        ),
      );
    });
  }

  Widget _buildAddress() {
    return InkWell(
      onTap: () => Get.toNamed(Routes.address, arguments: true),
      child: Container(
        color: ColorConstants.lightGray,
        padding: const EdgeInsets.symmetric(vertical: 8),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BaseText('${cartItems.length} items',
              fontSize: 16, color: Colors.grey),
        ),
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: cartItems.length,
            itemBuilder: (context, index) =>
                OrderItemCard(cartItem: cartItems[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderReview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseText(
            'Order Review',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BaseText('Subtotal'),
                  BaseCurrencyText(
                    controller.subtotal,
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
          const Divider(thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BaseText('Amount'),
              if (controller.amount != null)
                BaseCurrencyText(
                  controller.amount!,
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
      onTap: () => Get.toNamed(Routes.checkout + Routes.selectTicket),
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

  Widget _buildPaymentMethod() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            'Payment',
            fontSize: 16,
            color: ColorConstants.black,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: 12,
              children: List<Widget>.from(
                [
                  {
                    'value': PaymentMethod.cod,
                    'image': 'assets/icons/cod.png',
                  },
                  {
                    'value': PaymentMethod.paypal,
                    'image': 'assets/icons/paypal.png',
                  },
                ].map(
                  (e) => InkWell(
                    onTap: () => controller.selectedPaymentMethod.value =
                        e['value'] as PaymentMethod,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.lightGray,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.selectedPaymentMethod == e['value']
                              ? ColorConstants.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(e['image'] as String, width: 48),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
