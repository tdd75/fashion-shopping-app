import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:get/get.dart';

class Notify {
  static void info(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Info',
      message,
      colorText: ColorConstants.white,
      backgroundColor: ColorConstants.info,
    );
  }

  static void success(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Success',
      message,
      colorText: ColorConstants.white,
      backgroundColor: ColorConstants.success,
    );
  }

  static void warning(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Warning',
      message,
      colorText: ColorConstants.black,
      backgroundColor: ColorConstants.warning,
    );
  }

  static void error(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Error',
      message,
      colorText: ColorConstants.white,
      backgroundColor: ColorConstants.error,
    );
  }
}
