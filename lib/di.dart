import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/services/dotenv_service.dart';
import 'package:fashion_shopping_app/core/services/paypal_service.dart';
import 'package:fashion_shopping_app/core/services/storage_service.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => DotenvService().init());
    await Get.putAsync(() => PaypalService().init());
  }
}
