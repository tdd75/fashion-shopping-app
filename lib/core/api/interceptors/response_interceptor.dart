import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/core/models/common/error_response.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';

FutureOr<dynamic> responseInterceptor(
  Request request,
  Response response,
) async {
  if (!response.status.isOk) {
    handleErrorStatus(response);
  }
  return response;
}

void handleErrorStatus(Response response) async {
  final message = ErrorResponse.fromMap(response.body);

  if (!response.status.isOk) {
    Notify.error(message.error);
  }

  // redirect to auth screen when receive status 401
  switch (response.statusCode) {
    case 401:
      if (!Get.currentRoute.startsWith(Routes.auth)) {
        // try to refresh token
        final prefs = Get.find<SharedPreferences>();
        // TODO: Remove when backend logic completed
        const token = null;
        // final token = prefs.containsKey(StorageKey.refresh)
        //     ? await Get.find<AuthRepository>()
        //         .refreshToken(prefs.getString(StorageKey.refresh)!)
        //     : null;

        if (token == null) {
          prefs
            ..remove(StorageKey.access)
            ..remove(StorageKey.refresh);
          Get.toNamed(Routes.auth);
        }
      }
      break;
    default:
  }
}
