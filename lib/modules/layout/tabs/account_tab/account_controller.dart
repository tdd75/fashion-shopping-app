import 'package:fashion_shopping_app/core/models/request/password_change.dart';
import 'package:fashion_shopping_app/core/repositories/auth_repository.dart';
import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/enums/layout_tabs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  final AuthRepository authRepository;

  AccountController({
    required this.authRepository,
  });

  var isLoading = false.obs;
  var currentTab = LayoutTabs.home.obs;
  var discountNotification = true.obs;

  final changePasswordFormKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    final prefs = Get.find<SharedPreferences>();
    discountNotification.value = prefs.getBool('discountNotification') ?? true;

    isLoading.value = false;
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

  Future<bool?> changePassword() async {
    if (changePasswordFormKey.currentState!.validate()) {
      final result = await authRepository.changePassword(PasswordChange(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      ));
      return result;
    }
    return null;
  }

  toggleDiscountNotification() {
    if (discountNotification.value) {
      FirebaseMessaging.instance.subscribeToTopic('discount');
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic('discount');
    }
  }
}
