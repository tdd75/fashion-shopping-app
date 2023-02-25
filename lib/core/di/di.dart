import 'package:fashion_shopping_app/core/di/services/firebase_service.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/di/services/dotenv_service.dart';
import 'package:fashion_shopping_app/core/di/services/storage_service.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => DotenvService().init());
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => FirebaseService().init());
  }
}
