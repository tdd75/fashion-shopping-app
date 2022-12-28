import 'package:fashion_shopping_app/modules/auth/data/model/token.dart';
import 'package:fashion_shopping_app/modules/auth/data/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'package:fashion_shopping_app/core/api/client.dart';
import 'package:fashion_shopping_app/core/api/http_exception.dart';

class AuthRepository {
  final baseUrl = '${dotenv.get("DOMAIN")}/auth';

  Future<Token> login(String username, String password) async {
    try {
      final response = await Client.instance.post('$baseUrl/login', data: {
        'username': username,
        'password': password,
      });
      return Token.fromJson(response.data['result']);
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    }
  }

  Future<User> register({
    required String username,
    required String password,
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await Client.instance
          .post('${dotenv.get("DOMAIN")}/user/create', data: {
        'username': username,
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      });
      return User.fromJson(response.data['result']);
    } on DioError catch (error) {
      throw HttpException(error.response!.data['result'].values.join('\n'));
    }
  }

  Future<Token> loginGoogle(String idToken) async {
    try {
      final response = await Client.instance
          .post('$baseUrl/oauth-google/', data: {'token': idToken});
      return Token.fromJson(response.data);
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    }
  }

  Future<Token> loginFacebook(String idToken) async {
    try {
      final response = await Client.instance
          .post('$baseUrl/oauth-facebook/', data: {'token': idToken});
      return Token.fromJson(response.data);
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final response = await Client.instance.post(
          '${dotenv.get("DOMAIN")}/user/forgot-password',
          data: {'email': email});
      return response.data['result'] == 'Success';
    } on DioError catch (error) {
      throw HttpException(error.response!.data['result'].values.join('\n'));
    }
  }

  Future<bool> verifyCodeForgotPassword(String code, String email) async {
    try {
      final response = await Client.instance.post(
          '${dotenv.get("DOMAIN")}/user/verify-code-reset-password',
          data: {'code': code, 'email': email});
      return response.data['result'] == 'Success';
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    }
  }

  Future<bool> resetPassword(String password, String email) async {
    try {
      final response = await Client.instance.post(
          '${dotenv.get("DOMAIN")}/user/reset-password',
          data: {'password': password, 'email': email});
      return response.data['result'] == 'Success';
    } on DioError catch (error) {
      throw HttpException(error.response!.data['message']);
    }
  }
}
