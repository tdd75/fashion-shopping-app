import 'dart:async';

import 'package:fashion_shopping_app/core/models/request/recover_password.dart';
import 'package:fashion_shopping_app/core/models/request/verify_code.dart';
import 'package:fashion_shopping_app/shared/constants/storage_key.dart';
import 'package:fashion_shopping_app/shared/helpers/focus.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/core/models/request/login.dart';
import 'package:fashion_shopping_app/core/models/request/register.dart';
import 'package:fashion_shopping_app/core/repositories/auth_repository.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  // Login
  final loginFormKey = GlobalKey<FormState>();
  final loginIdentifyController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final rememberMe = false.obs;

  // Register
  final registerFormKey = GlobalKey<FormState>();
  final registerFirstNameController = TextEditingController();
  final registerLastNameController = TextEditingController();
  final registerUsernameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  var registerTermsChecked = false.obs;

  // Forgot password
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final forgotEmailController = TextEditingController();

  final verifyCodeFormKey = GlobalKey<FormState>();
  final verifyCodeController = TextEditingController();
  final verifyErrorController = StreamController<ErrorAnimationType>();

  final newPasswordFormKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  // oauth
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: dotenv.get('GOOGLE_CLIENT_ID'),
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );

  @override
  void onInit() {
    super.onInit();

    final prefs = Get.find<SharedPreferences>();
    if (prefs.containsKey(StorageKey.identify)) {
      loginIdentifyController.text = prefs.getString(StorageKey.identify)!;
      rememberMe.value = true;
    }
  }

  void _saveToken(String access, String refresh) {
    final prefs = Get.find<SharedPreferences>();
    if (access.isNotEmpty) {
      prefs
        ..setString(StorageKey.access, access)
        ..setString(StorageKey.refresh, refresh);

      if (rememberMe.value) {
        prefs.setString(StorageKey.identify, loginIdentifyController.text);
      } else {
        prefs.remove(StorageKey.identify);
      }

      Get.toNamed(Routes.layout);
    }
  }

  Future<void> login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      final res = await authRepository.login(
        Login(
          identify: loginIdentifyController.text,
          password: loginPasswordController.text,
        ),
      );
      if (res == null) return;
      _saveToken(res.access, res.refresh);
    }
  }

  Future<void> oauthGoogle() async {
    final signInData = await _googleSignIn.signIn();
    final sessionData = await signInData!.authentication;
    final res = await authRepository.oauthGoogle(sessionData.idToken!);
    if (res == null) return;
    _saveToken(res.access, res.refresh);
  }

  Future<void> oauthFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status != LoginStatus.success) {
      Notify.error('Something went wrong');
      return;
    }
    final accessToken = result.accessToken!;
    final res = await authRepository.oauthFacebook(accessToken.token);
    if (res == null) return;
    _saveToken(res.access, res.refresh);
  }

  Future<void> register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      if (!registerTermsChecked.value) {
        Notify.warning('Please check the terms first.');
        return;
      }
      final res = await authRepository.register(
        Register(
          firstName: registerFirstNameController.text,
          lastName: registerLastNameController.text,
          username: registerUsernameController.text,
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );
      if (!res) return;
      registerFormKey.currentState!.reset();
      Notify.success('Create new account successfully.');
      Get.offAndToNamed(Routes.auth + Routes.login, arguments: this);
    }
  }

  Future<bool> forgotPassword() async {
    if (forgotPasswordFormKey.currentState!.validate()) {
      return await authRepository.forgotPassword(forgotEmailController.text);
    }
    return false;
  }

  Future<bool> verifyCode() async {
    if (verifyCodeFormKey.currentState!.validate()) {
      return await authRepository.verifyCode(VerifyCode(
        email: forgotEmailController.text,
        code: verifyCodeController.text,
      ));
    }
    return false;
  }

  Future<bool> recoverPassword() async {
    if (newPasswordFormKey.currentState!.validate()) {
      if (newPasswordController.text != confirmNewPasswordController.text) {
        Notify.warning('New password and confirm password are not the same.');
        return false;
      }
      return await authRepository.recoverPassword(RecoverPassword(
        email: forgotEmailController.text,
        code: verifyCodeController.text,
        newPassword: newPasswordController.text,
      ));
    }
    return false;
  }
}
