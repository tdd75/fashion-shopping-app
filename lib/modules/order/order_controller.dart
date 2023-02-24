import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/repositories/order_repository.dart';
import 'package:fashion_shopping_app/core/repositories/transaction_repository.dart';
import 'package:fashion_shopping_app/shared/enums/order_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final OrderRepository orderRepository;
  final TransactionRepository transactionRepository;

  OrderController({
    required this.orderRepository,
    required this.transactionRepository,
  });

  var isLoading = false.obs;
  var toPayOrders = Rx<List<Order>>([]);
  var toShipOrders = Rx<List<Order>>([]);
  var toReceiveOrders = Rx<List<Order>>([]);
  var completedOrders = Rx<List<Order>>([]);
  var cancelledOrders = Rx<List<Order>>([]);

  final isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();

  late TabController tabController;

  OrderTabs get currentTab => OrderTabs.values[tabController.index];

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    tabController = TabController(vsync: this, length: OrderTabs.values.length);
    tabController.addListener(_triggerChangeTab);
    await fetchOrders(currentTab);
    isLoading.value = false;
  }

  @override
  void onClose() {
    tabController.removeListener(_triggerChangeTab);
    super.onClose();
  }

  Future<void> _triggerChangeTab() async {
    if (tabController.indexIsChanging) return;
    if (tabController.index != tabController.previousIndex) {
      fetchOrders(currentTab);
    }
  }

  Rx<List<Order>>? mappingOrderTabWithData(OrderTabs tab) {
    switch (tab) {
      case OrderTabs.toPay:
        return toPayOrders;
      case OrderTabs.toShip:
        return toShipOrders;
      case OrderTabs.toReceive:
        return toReceiveOrders;
      case OrderTabs.completed:
        return completedOrders;
      case OrderTabs.cancelled:
        return cancelledOrders;
      default:
        return null;
    }
  }

  Future<void> fetchOrders(OrderTabs tab) async {
    final response = await orderRepository.getList(
      params: {'stage': tab.value},
    );
    if (response != null) {
      mappingOrderTabWithData(tab)!.value = response.results;
    }
  }
}
