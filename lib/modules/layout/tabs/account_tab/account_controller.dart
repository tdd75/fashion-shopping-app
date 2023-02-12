import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:fashion_shopping_app/core/repositories/user_repository.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/enums/layout_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  final UserRepository userRepository;
  final AddressRepository addressRepository;

  AccountController({
    required this.userRepository,
    required this.addressRepository,
  });

  var isLoading = false.obs;
  var currentTab = LayoutTabs.home.obs;
  var user = Rxn<User>();
  final address = Rxn<Address>();
  final searchController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchUserInfo();
    await fetchDefaultAddress();
    isLoading.value = false;
  }

  Future<void> fetchUserInfo() async {
    user.value = await userRepository.getInfo();
  }

  Future<void> fetchDefaultAddress() async {
    final response =
        await addressRepository.getList(params: {'is_default': true});
    if (response != null) {
      address.value = response.results.first;
    }
  }

  void logout() {
    final prefs = Get.find<SharedPreferences>();
    final identify = prefs.getString(StorageKey.identify);
    prefs.clear();
    if (identify != null) {
      prefs.setString(StorageKey.identify, identify);
    }
    Get.offAllNamed(Routes.auth);
  }
}
