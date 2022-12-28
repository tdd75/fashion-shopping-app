import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:fashion_shopping_app/core/api/client.dart';
import 'package:fashion_shopping_app/modules/auth/bloc/state/login_state.dart';
import 'package:fashion_shopping_app/modules/auth/data/model/token.dart';
import 'package:fashion_shopping_app/modules/auth/data/repository/auth_repository.dart';
import 'package:fashion_shopping_app/core/api/http_response.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: dotenv.get('GOOGLE_CLIENT_ID'),
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  LoginCubit({required this.authRepository}) : super(const LoginState());

  void updateState({
    String? email,
    String? password,
    bool? rememberMe,
  }) {
    emit(state.copyWith(
      email: email,
      password: password,
      rememberMe: rememberMe,
    ));
  }

  Future<HttpResponse<Token>> login() async {
    try {
      final loginData = await authRepository.login(state.email, state.password);
      _saveToken(
        loginData.access,
        username: state.rememberMe ? state.email : null,
      );
      return HttpResponse(data: loginData);
    } catch (error) {
      return HttpResponse(error: error.toString());
    }
  }

  Future<HttpResponse<Token>> loginGoogle() async {
    try {
      final signInData = await _googleSignIn.signIn();
      final sessionData = await signInData!.authentication;

      final loginData = await authRepository.loginGoogle(sessionData.idToken!);
      _saveToken(loginData.access);
      return HttpResponse(data: loginData);
    } catch (error) {
      return HttpResponse(error: error.toString());
    }
  }

  Future<HttpResponse<Token>> loginFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        final loginData = await authRepository.loginFacebook(accessToken.token);
        _saveToken(loginData.access);
        return HttpResponse(data: loginData);
      } else {
        return HttpResponse(error: 'Login by Facebook failed!');
      }
    } catch (error) {
      return HttpResponse(error: error.toString());
    }
  }

  // private methods
  void _saveToken(String access, {String? username}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access', access);
    if (username != null) {
      prefs.setString('username', username);
    }
    Client.setToken(access);
  }
}
