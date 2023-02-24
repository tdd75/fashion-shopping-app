import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/enums/order_tabs.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/modules/order/order_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return DefaultTabController(
        length: OrderTabs.values.length,
        child: Scaffold(
          appBar: AppBar(
            title: controller.isSearching.value
                ? BaseInputField(
                    controller: controller.searchController,
                    hintText: 'Search by order code, product name',
                  )
                : const Text('Order'),
            // actions: [
            //   IconButton(
            //     icon: Icon(
            //         controller.isSearching.value ? Icons.clear : Icons.search),
            //     onPressed: () {
            //       if (controller.isSearching.value) {
            //         controller.searchController.clear();
            //         controller.isSearching.value = false;
            //         return;
            //       }
            //       controller.isSearching.value = true;
            //       // _clearSearchQuery();
            //     },
            //   ),
            // ],
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: ColorConstants.primary,
              controller: controller.tabController,
              tabs: OrderTabs.values.map((e) => Tab(text: e.title)).toList(),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: List<Widget>.from(
              OrderTabs.values.map((e) => _buildOrderList(e)),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOrderList(OrderTabs tab) {
    final orderData = controller.mappingOrderTabWithData(tab)!.value;
    if (orderData.isEmpty) return const NoItem();
    return ListView.separated(
      itemCount: orderData.length,
      itemBuilder: (context, index) {
        final order = orderData[index];
        final firstItem = order.orderItems[0];
        return _buildCard(firstItem, order);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }

  Widget _buildCard(CartItem firstItem, Order order) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.orderDetail, arguments: order.id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    firstItem.productVariant.product!.image,
                    height: 56,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BaseText(
                              firstItem.productVariant.product!.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(height: 4),
                            BaseText(
                              '${firstItem.productVariant.color} - ${firstItem.productVariant.size}',
                              color: Colors.grey,
                            ),
                            BaseText(
                              'Quantity: ${firstItem.quantity}',
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        BaseCurrencyText(
                          firstItem.productVariant.price,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText('${order.orderItems.length} items'),
                  Row(
                    children: [
                      const BaseText('Total: '),
                      BaseCurrencyText(
                        order.amount,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText('Code: ${order.code}', fontSize: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
