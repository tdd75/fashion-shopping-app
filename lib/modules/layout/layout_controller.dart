import 'package:fashion_shopping_app/core/constants/tabs.dart';
import 'package:fashion_shopping_app/core/models/response/list_response.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:fashion_shopping_app/modules/home_tab/home_tab.dart';
import 'package:fashion_shopping_app/modules/inbox_tab/inbox_tab.dart';
import 'package:fashion_shopping_app/modules/account_tab/account_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  LayoutController();

  var currentTab = MainTabs.home.obs;
  var user = Rxn<User>();
  var products = Rxn<ListResponse<Product>>();
  final searchController = TextEditingController();

  late HomeTab homeTab;
  // late DiscoverTab discoverTab;
  // late ResourceTab resourceTab;
  late InboxTab inboxTab;
  late AccountTab accountTab;

  @override
  void onInit() {
    super.onInit();

    homeTab = const HomeTab();
    // discoverTab = const DiscoverTab();
    // resourceTab = const ResourceTab();
    inboxTab = const InboxTab();
    accountTab = const AccountTab();
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    return tab.index;
  }

  MainTabs _getCurrentTab(int index) {
    return MainTabs.values[index];
  }
}
