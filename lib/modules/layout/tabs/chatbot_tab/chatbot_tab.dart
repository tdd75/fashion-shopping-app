import 'package:fashion_shopping_app/core/models/response/bot_message.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/chatbot_tab/chatbot_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/cart/cart_item_widget.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/receive_msg_box.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/send_msg_box.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/shared/widgets/order/order_card.dart';
import 'package:fashion_shopping_app/shared/widgets/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotTab extends GetView<ChatbotController> {
  const ChatbotTab({super.key});

  bool get isComposing => controller.isComposing.value;
  List<BotMessage> get messages => controller.messages.value;
  TextEditingController get textController => controller.textController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Bot'),
        ),
        body: Column(
          children: [
            Flexible(
              child: _buildMessageList(),
            ),
            const Divider(height: 1),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMessageList() {
    return Obx(() {
      if (messages.isEmpty) return const NoItem();
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (_, index) {
          final message = messages[index];
          if (message.isUser != null) {
            return SendMsgBox(message: message.text!);
          }
          if (message.text != null) {
            return ReceiveMsgBox(
              message: message.text!,
              avatar:
                  'https://static.vecteezy.com/system/resources/previews/004/996/790/original/robot-chatbot-icon-sign-free-vector.jpg',
            );
          }
          switch (message.custom?.payload) {
            case 'list_product':
              final products = message.custom!.data
                  .map((product) => ProductShort.fromMap(product))
                  .toList();
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                ),
              );
            case 'order_status':
              final orders = message.custom!.data
                  .map((order) => Order.fromMap(order))
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return OrderCard(order: order);
                  },
                ),
              );
            case 'place_order':
              final cartItems = List<CartItem>.from(message.custom!.data
                  .map((cartItem) => CartItem.fromMap(cartItem)));
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: ColorConstants.lightGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartItems.length + 2,
                  itemBuilder: (context, index) {
                    if (index == cartItems.length) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 8,
                        ),
                        child: BaseButton(
                          text: 'No, go to cart',
                          onPressed: () => Get.toNamed(Routes.cart),
                        ),
                      );
                    }
                    if (index == cartItems.length + 1) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: BaseButton(
                          text: 'Yes, checkout now',
                          onPressed: () => Get.toNamed(Routes.checkout,
                              arguments: cartItems),
                          color: Colors.blue,
                        ),
                      );
                    }
                    final cartItem = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CartItemWidget(cartItem: cartItem),
                    );
                  },
                ),
              );
            default:
              return const SizedBox();
          }
        },
      );
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: ColorConstants.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onChanged: (text) {
                  controller.isComposing.value = text.isNotEmpty;
                },
                onSubmitted: isComposing ? _handleSubmitted : null,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: controller.focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: isComposing
                    ? () => _handleSubmitted(textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    textController.clear();
    controller.sendMessage(text);
    controller.focusNode.requestFocus();
  }
}
