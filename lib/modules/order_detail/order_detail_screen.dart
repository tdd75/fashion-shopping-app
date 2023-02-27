import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/modules/order/order_controller.dart';
import 'package:fashion_shopping_app/modules/order_detail/order_detail_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/enums/order_tabs.dart';
import 'package:fashion_shopping_app/shared/enums/payment_method.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/shared/widgets/address/address_card.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/order/order_item.dart';
import 'package:fashion_shopping_app/shared/widgets/reviews/reviews_dialog.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  Order get order => controller.order.value!;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return WillPopScope(
        onWillPop: () async {
          try {
            final orderController = Get.find<OrderController>();
            orderController.fetchOrdersByTab(orderController.currentTab);
          } catch (e) {
            // ignore
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Order Detail'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [
                          const BaseText(
                            'Order Code: ',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          BaseText(
                            '#${controller.order.value!.code}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.primary,
                          ),
                        ],
                      ),
                      BaseText(
                        OrderTabs.values
                            .firstWhere((e) => e.value == order.stage)
                            .title,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: order.stage == OrderTabs.completed.value
                            ? ColorConstants.success
                            : order.stage == OrderTabs.cancelled.value
                                ? ColorConstants.error
                                : ColorConstants.primary,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AddressCard(address: order.address!),
                ),
                _buildOrderItemList(),
                const SizedBox(height: 24),
                _buildOrderDetails(),
                const SizedBox(height: 12),
                _buildPaymentMethod(),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomBar(context),
        ),
      );
    });
  }

  Widget? _buildBottomBar(BuildContext context) {
    Widget? button;

    if (order.stage == OrderTabs.completed.value &&
        controller.notReviewedItems.isNotEmpty) {
      button = BaseButton(
        text: 'Reviews',
        onPressed: () async {
          for (final cartItem in controller.notReviewedItems) {
            double? rating;
            final reviewController = TextEditingController();
            await Get.defaultDialog(
              title: 'Reviews',
              titlePadding: const EdgeInsets.symmetric(vertical: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              content: ReviewsDialog(
                onChangeRating: (value) {
                  rating = value;
                },
                controller: reviewController,
                onSubmit: () {
                  if (rating == null) {
                    return Notify.error('Please select rating');
                  }
                  if (reviewController.text.isEmpty) {
                    return Notify.error('Please input review');
                  }
                  controller.submitReviews(
                    cartItem.productVariant.id,
                    reviewController.text,
                    rating!,
                  );
                  Get.back();
                  Notify.success('Reviews submitted successfully. Thank you!');
                },
                cartItem: cartItem,
              ),
            );
          }
          await controller.fetchOrder();
        },
      );
    } else if ([OrderTabs.toPay.value, OrderTabs.toShip.value]
        .contains(order.stage)) {
      button = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (order.stage == OrderTabs.toPay.value)
            BaseButton(
              text: 'Pay now',
              onPressed: () async {
                final paymentLink = await controller.transactionRepository
                    .create(controller.id);
                if (paymentLink != null) {
                  final paymentUri = Uri.parse(paymentLink);
                  if (await canLaunchUrl(paymentUri)) {
                    await launchUrl(paymentUri);
                  }
                }
              },
            ),
          const SizedBox(height: 8),
          BaseButton(
            text: 'Cancel Order',
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Cancel Order'),
                      content: const Text('Are you sure to cancel this order?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final res = await controller.orderRepository
                                .cancelOrder(controller.id);
                            if (res == true) {
                              Get.back();
                              Notify.success('Order has been cancelled');
                              controller.fetchOrder();
                            }
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  });
            },
            color: ColorConstants.error,
          ),
        ],
      );
    } else if (order.stage == OrderTabs.toReceive.value) {
      button = BaseButton(
          text: 'Confirm Received',
          onPressed: () async {
            final res =
                await controller.orderRepository.confirmReceived(controller.id);
            if (res == true) {
              Get.back();
              Notify.success('Update order status successfully');
              final orderController = Get.find<OrderController>();
              orderController.fetchOrdersByTab(orderController.currentTab);
            }
          });
    }
    if (button == null) return null;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: button,
    );
  }

  Widget _buildOrderItemList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: BaseText(
            'Order Items',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shrinkWrap: true,
          itemCount: order.orderItems.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => OrderItemCard(
            cartItem: order.orderItems[index],
            onlyContent: true,
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseText(
            'Order Summary',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText('Subtotal'),
                    BaseCurrencyText(
                      controller.order.value!.subtotal,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // if (controller.discount != null)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       BaseText('Discount', color: ColorConstants.red),
                //       Wrap(
                //         spacing: 4,
                //         children: [
                //           BaseText(
                //             '-',
                //             color: ColorConstants.red,
                //             fontWeight: FontWeight.w400,
                //           ),
                //           BaseCurrencyText(
                //             controller.discount!,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400,
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
              ],
            ),
          ),
          const Divider(thickness: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BaseText('Amount', fontSize: 16),
              BaseCurrencyText(
                controller.order.value!.amount,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            'Payment',
            color: ColorConstants.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          BaseText(
            'Payment method: ${controller.order.value!.paymentMethod.value}',
            color: ColorConstants.black,
          ),
          const SizedBox(height: 4),
          if (PaymentMethod.fromString(
                  controller.order.value!.paymentMethod.value) !=
              PaymentMethod.cod)
            controller.order.value?.paidAt != null
                ? BaseText(
                    'Paid at: ${DateFormat('yyyy-MM-dd – kk:mm').format(controller.order.value!.paidAt!)}',
                    color: ColorConstants.black,
                  )
                : BaseText(
                    'Not paid yet',
                    color: ColorConstants.black,
                  ),
        ],
      ),
    );
  }
}
