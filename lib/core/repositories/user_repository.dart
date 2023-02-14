import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/user_update.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:get/get.dart';

class UserRepository {
  final ApiProvider apiProvider = Get.find();

  Future<User?> getInfo() async {
    final res = await apiProvider.get('/users/me/');
    return res.status.isOk ? User.fromMap(res.body) : null;
  }

  Future<User?> updateInfo(UserUpdate data) async {
    final res = await apiProvider.patch('/users/me/', data.toJson(partial: true));
    return res.status.isOk ? User.fromMap(res.body) : null;
  }
}
