import 'dart:async';
import 'dart:convert';

import 'package:fashion_shopping_app/core/api/api_provider.dart';
import 'package:fashion_shopping_app/core/models/request/login_request.dart';
import 'package:fashion_shopping_app/core/models/request/register_request.dart';
import 'package:fashion_shopping_app/core/models/response/token.dart';


class AuthRepository {
  final ApiProvider apiProvider;

  AuthRepository({required this.apiProvider});

  Future<Token?> login(LoginRequest data) async {
    final res = await apiProvider.post('/auth/login/', data.toJson());
    if (res.status.isOk) {
      return Token.fromMap(res.body);
    }
    return null;
  }

  Future<Token?> oauthGoogle(String token) async {
    final res = await apiProvider.post(
      '/auth/oauth-google/',
      json.encode({'token': token}),
    );
    if (res.status.isOk) {
      return Token.fromMap(res.body);
    }
    return null;
  }

  Future<Token?> oauthFacebook(String token) async {
    final res = await apiProvider.post(
      '/auth/oauth-facebook/',
      json.encode({'token': token}),
    );
    if (res.status.isOk) {
      return Token.fromMap(res.body);
    }
    return null;
  }

  Future<bool> register(RegisterRequest data) async {
    final res = await apiProvider.post('/auth/register/', data.toJson());
    return res.status.isOk;
  }

  Future<String?> refreshToken(String refresh) async {
    final res = await apiProvider.post(
      '/auth/register/',
      json.encode({'refresh': refresh}),
    );
    if (res.status.isOk) {
      return res.body['access'];
    }
    return null;
  }
}
