import 'dart:async';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';


class UserRepository {
  UserRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<User?> getInfo() async {
    final res = await apiProvider.get('/users/me');
    if (res.status.isOk) {
      return User.fromMap(res.body);
    }
    return null;
  }
}
