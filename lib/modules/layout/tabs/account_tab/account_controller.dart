import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:fashion_shopping_app/shared/constants/tabs.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:fashion_shopping_app/core/repositories/user_repository.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  final UserRepository userRepository;

  AccountController({required this.userRepository});

  var isLoading = false.obs;
  var currentTab = Tabs.home.obs;
  var user = Rxn<User>();
  final searchController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchUserInfo();
    isLoading.value = false;
  }

  Future<void> fetchUserInfo() async {
    user.value = await userRepository.getInfo();
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
