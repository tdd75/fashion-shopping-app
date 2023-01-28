import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/checkbox/base_checkbox.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/modules/auth/auth_controller.dart';
import 'package:fashion_shopping_app/modules/auth/widgets/oauth_buttons.dart';

import '../../core/routes/app_pages.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  RegisterScreen({super.key});

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
                  const BaseText('Sign in with', fontSize: 16),
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
      key: controller.registerFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BaseText(
              'Sign up',
              fontSize: 36,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildFirstNameField()),
                const SizedBox(width: 12),
                Expanded(child: _buildLastNameField()),
              ],
            ),
            const SizedBox(height: 12),
            _buildUsernameField(),
            const SizedBox(height: 12),
            _buildEmailField(),
            const SizedBox(height: 12),
            _buildPasswordField(),
            const SizedBox(height: 12),
            _buildConfirmPasswordField(),
            const SizedBox(height: 28),
            Obx(() => BaseCheckbox(
                  label:
                      'I have read and agreed to the Terms & Conditions and Privay Policy of Fashion Shopping App.',
                  checked: controller.registerTermsChecked.value,
                  onChecked: (val) {
                    controller.registerTermsChecked.value = val!;
                  },
                )),
            const SizedBox(height: 16),
            BaseButton(
              text: 'Sign Up',
              onPressed: () => controller.register(context),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Get.offAndToNamed(
                      Routes.auth + Routes.login,
                      arguments: controller,
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstNameField() {
    return BaseInputField(
      controller: controller.registerFirstNameController,
      hintText: 'First name',
      prefixIcon: const Icon(Icons.badge),
      validator: (value) {
        if (value!.isEmpty) {
          return 'First name is required.';
        }
        return null;
      },
    );
  }

  Widget _buildLastNameField() {
    return BaseInputField(
      controller: controller.registerLastNameController,
      hintText: 'Last name',
      prefixIcon: const Icon(Icons.badge),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Last name is required.';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return BaseInputField(
      controller: controller.registerEmailController,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
      hintText: 'Email',
      validator: (value) {
        if (!GetUtils.isEmail(value!)) {
          return 'Email format error.';
        }
        if (value.isEmpty) {
          return 'Email is required.';
        }
        return null;
      },
    );
  }

  Widget _buildUsernameField() {
    return BaseInputField(
      controller: controller.registerUsernameController,
      prefixIcon: const Icon(Icons.account_circle),
      hintText: 'Username',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Username is required.';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return BaseInputField(
      controller: controller.registerPasswordController,
      hintText: 'Password',
      prefixIcon: const Icon(Icons.lock),
      isPasswordField: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password is required.';
        }
        if (value.length < 6 || value.length > 15) {
          return 'Password should be 6~15 characters';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return BaseInputField(
      controller: controller.registerConfirmPasswordController,
      hintText: 'Confirm Password',
      prefixIcon: const Icon(Icons.lock),
      isPasswordField: true,
      validator: (value) {
        if (controller.registerPasswordController.text !=
            controller.registerConfirmPasswordController.text) {
          return 'Confirm Password is not consistence with Password.';
        }
        if (value!.isEmpty) {
          return 'Confirm Password is required.';
        }
        return null;
      },
    );
  }
}
