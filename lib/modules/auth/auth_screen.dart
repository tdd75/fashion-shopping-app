import 'package:fashion_shopping_app/core/constants/color.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/core/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/core/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'widgets/oauth_buttons.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _buildItems(context),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        Padding(
          padding: const EdgeInsets.all(96),
          child: Image.asset('assets/icons/logo.png'),
        ),
        const SizedBox(height: 12),
        BaseText(
          'WELCOME',
          textAlign: TextAlign.center,
          fontSize: 36,
          fontWeight: FontWeight.w500,
          color: ColorConstants.secondary,
        ),
        const SizedBox(height: 10),
        BaseText(
          'Let\'s start now!',
          textAlign: TextAlign.center,
          fontSize: 20,
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
        const SizedBox(height: 50),
        BaseButton(
          text: 'Login',
          onPressed: () {
            Get.toNamed(Routes.auth + Routes.login, arguments: controller);
          },
        ),
        const SizedBox(height: 16),
        BaseButton(
          text: 'Sign Up',
          onPressed: () {
            Get.toNamed(Routes.auth + Routes.register, arguments: controller);
          },
        ),
        const SizedBox(height: 62),
        Column(
          children: [
            const BaseText('Sign in with', fontSize: 16),
            const SizedBox(height: 4),
            OauthButtons(),
          ],
        ),
      ],
    );
  }
}
