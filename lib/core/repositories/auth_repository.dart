import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/login.dart';
import 'package:fashion_shopping_app/core/models/request/recover_password.dart';
import 'package:fashion_shopping_app/core/models/request/register.dart';
import 'package:fashion_shopping_app/core/models/request/verify_code.dart';
import 'package:fashion_shopping_app/core/models/response/token.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiProvider apiProvider = Get.find();

  Future<Token?> login(Login data) async {
    final res = await apiProvider.post('/auth/login/', data.toJson());
    return res.status.isOk ? Token.fromMap(res.body) : null;
  }

  Future<Token?> oauthGoogle(String token) async {
    final res = await apiProvider.post(
      '/auth/oauth-google/',
      json.encode({'token': token}),
    );
    return res.status.isOk ? Token.fromMap(res.body) : null;
  }

  Future<Token?> oauthFacebook(String token) async {
    final res = await apiProvider.post(
      '/auth/oauth-facebook/',
      json.encode({'token': token}),
    );
    return res.status.isOk ? Token.fromMap(res.body) : null;
  }

  Future<bool> register(Register data) async {
    final res = await apiProvider.post('/auth/register/', data.toJson());
    return res.status.isOk;
  }

  Future<String?> refreshToken(String refresh) async {
    final res = await apiProvider.post(
      '/auth/token/refresh/',
      json.encode({'refresh': refresh}),
    );
    return res.status.isOk ? res.body['access'] : null;
  }

  Future<bool> forgotPassword(String email) async {
    final res = await apiProvider.post(
      '/auth/forgot-password/',
      json.encode({'email': email}),
    );
    return res.status.isOk;
  }

  Future<bool> recoverPassword(RecoverPassword data) async {
    final res =
        await apiProvider.post('/auth/recover-password/', data.toJson());
    return res.status.isOk;
  }

  Future<bool> verifyCode(VerifyCode data) async {
    final res = await apiProvider.post('/auth/verify-code/', data.toJson());
    return res.status.isOk;
  }
}
