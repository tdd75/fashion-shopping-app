import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/enums/order_tabs.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/shared/widgets/order/order_card.dart';
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
        return OrderCard(order: order);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
