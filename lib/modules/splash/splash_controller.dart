// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fashion_shopping_app/core/constants/storage_key.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    final prefs = Get.find<SharedPreferences>();
    try {
      if (prefs.getString(StorageKey.access) != null) {
        Get.toNamed(Routes.layout);
      } else {
        Get.toNamed(Routes.auth);
      }
    } catch (e) {
      Get.toNamed(Routes.auth);
    }
  }
}
