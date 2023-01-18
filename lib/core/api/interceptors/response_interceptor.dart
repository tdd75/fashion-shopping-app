import 'dart:async';
import 'package:fashion_shopping_app/core/constants/storage_key.dart';
import 'package:fashion_shopping_app/core/helpers/notify.dart';
import 'package:fashion_shopping_app/core/models/response/error_response.dart';
import 'package:fashion_shopping_app/core/repositories/auth_repository.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:shared_preferences/shared_preferences.dart';

FutureOr<dynamic> responseInterceptor(
  Request request,
  Response response,
) async {
  EasyLoading.dismiss();
  if (!response.status.isOk) {
    handleErrorStatus(response);
  }
  return response;
}

void handleErrorStatus(Response response) {
  final message = ErrorResponse.fromMap(response.body);

  // redirect to auth screen when receive status 401
  switch (response.statusCode) {
    case 401:
      if (!Get.currentRoute.startsWith(Routes.auth)) {
        // try to refresh token
        final prefs = Get.find<SharedPreferences>();
        final token = prefs.containsKey(StorageKey.refresh)
            ? Get.find<AuthRepository>()
                .refreshToken(prefs.getString(StorageKey.refresh)!)
            : null;

        if (token == null) {
          prefs
            ..remove(StorageKey.access)
            ..remove(StorageKey.refresh);
          Notify.warning(
            'Your login session has expired, please login again.',
            title: 'Session expired',
          );
          Get.toNamed(Routes.auth);
        }
      }
      return;
    default:
  }

  if (!response.status.isOk) {
    Notify.error(message.error);
  }
}
