import 'dart:async';
import 'package:fashion_shopping_app/core/constants/storage_key.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<Request> requestInterceptor(request) async {
  final prefs = Get.find<SharedPreferences>();
  if (prefs.containsKey(StorageKey.access)) {
    final access = prefs.getString(StorageKey.access);
    request.headers['Authorization'] = 'Bearer $access';
  }
  EasyLoading.show();

  return request;
}
