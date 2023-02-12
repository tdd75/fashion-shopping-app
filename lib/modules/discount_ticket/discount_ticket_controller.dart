import 'package:fashion_shopping_app/shared/enums/discount_ticket_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/core/repositories/discount_ticket_repository.dart';

class DiscountTicketController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DiscountTicketRepository discountTicketRepository;

  DiscountTicketController({required this.discountTicketRepository});

  var isLoading = false.obs;
  var newestDiscountTickets = Rx<List<DiscountTicket>>([]);
  var savedDiscountTickets = Rx<List<DiscountTicket>>([]);
  late TabController tabController;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    tabController =
        TabController(vsync: this, length: DiscountTicketTabs.values.length);
    tabController.addListener(_triggerChangeTab);

    await fetchNewestTickets();
    await fetchSavedTickets();
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
      if (tabController.index == 0) {
        await fetchNewestTickets();
      } else {
        await fetchSavedTickets();
      }
    }
  }

  Future<void> fetchNewestTickets() async {
    final response =
        await discountTicketRepository.getList(params: {'is_saved': false});
    if (response != null) {
      newestDiscountTickets.value = response.results;
    }
  }

  Future<void> fetchSavedTickets() async {
    final response =
        await discountTicketRepository.getList(params: {'is_saved': true});
    if (response != null) {
      savedDiscountTickets.value = response.results;
    }
  }

  Future<bool> saveTicket(int id) async {
    final result = await discountTicketRepository.saveTicket(id);
    if (result) {
      await fetchNewestTickets();
    }
    return result;
  }
}
