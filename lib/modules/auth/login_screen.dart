import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/auth/forgot_password_screen.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/checkbox/base_checkbox.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/modules/auth/auth_controller.dart';
import 'package:fashion_shopping_app/modules/auth/widgets/oauth_buttons.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: _buildForms(context),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            children: [
              Column(
                children: [
                  const BaseText('Or sign in with', fontSize: 16),
                  const SizedBox(height: 4),
                  OauthButtons(),
                ],
              ),
              const SizedBox(height: 20, width: double.infinity),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BaseText(
              'Login',
              fontSize: 36,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildIdentifyField(),
            const SizedBox(height: 12),
            _buildPasswordField(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => SizedBox(
                      width: 120,
                      child: BaseCheckbox(
                        label: 'Remember me',
                        checked: controller.rememberMe.value,
                        onChecked: (value) =>
                            controller.rememberMe.value = value!,
                      ),
                    )),
                TextButton(
                  onPressed: () => Get.to(const ForgotPasswordScreen()),
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            BaseButton(
              text: 'Login',
              onPressed: () => controller.login(context),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed(
                      Routes.auth + Routes.register,
                      arguments: controller,
                    );
                  },
                  child: const Text('Register now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentifyField() {
    return BaseInputField(
      controller: controller.loginIdentifyController,
      keyboardType: TextInputType.text,
      hintText: 'Username or email',
      prefixIcon: const Icon(Icons.account_circle),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Username or email is required.';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return BaseInputField(
      controller: controller.loginPasswordController,
      hintText: 'Password',
      isPasswordField: true,
      prefixIcon: const Icon(Icons.lock),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password is required.';
        }
        if (value.length <= 4) {
          return 'Password should be greater than 4 characters';
        }
        return null;
      },
    );
  }
}
