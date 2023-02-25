import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/auth/auth_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.forgotPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const BaseText(
                'Forgot Password',
                fontSize: 36,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const BaseText(
                'Enter your email address below to receive a password reset OTP code in your email.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildEmailField(),
              const SizedBox(height: 32),
              BaseButton(
                text: 'Send',
                onPressed: () async {
                  EasyLoading.show();
                  final result = await controller.forgotPassword();
                  EasyLoading.dismiss();
                  if (result) Get.to(() => const VerifyCodeScreen());
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    Get.offNamedUntil(Routes.login, (route) => false),
                child: const BaseText('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return BaseInputField(
      controller: controller.forgotEmailController,
      hintText: 'Email',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!GetUtils.isEmail(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

class VerifyCodeScreen extends GetView<AuthController> {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.verifyCodeFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const BaseText(
                'Verify Code',
                fontSize: 36,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const BaseText(
                'Enter the OTP code sent to your email address.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildCodeField(context),
              TextButton(
                onPressed: () =>
                    Get.offNamedUntil(Routes.login, (route) => false),
                child: const BaseText('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeField(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveColor: ColorConstants.darkGray,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      errorAnimationController: controller.verifyErrorController,
      controller: controller.verifyCodeController,
      onCompleted: (v) async {
        EasyLoading.show();
        final result = await controller.verifyCode();
        EasyLoading.dismiss();
        if (result) {
          Get.to(() => const NewPasswordScreen());
        } else {
          controller.verifyErrorController.add(ErrorAnimationType.shake);
        }
      },
      onChanged: (value) {},
    );
  }
}

class NewPasswordScreen extends GetView<AuthController> {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.newPasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const BaseText(
                'New Password',
                fontSize: 36,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const BaseText(
                'Enter your new password below.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildPasswordField(),
              const SizedBox(height: 16),
              _buildConfirmPasswordField(),
              const SizedBox(height: 32),
              BaseButton(
                text: 'Change password',
                onPressed: () async {
                  EasyLoading.show();
                  final result = await controller.recoverPassword();
                  EasyLoading.dismiss();
                  if (result) Get.offNamedUntil(Routes.login, (route) => false);
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Notify.success('Change password successfully');
                  Get.offNamedUntil(Routes.login, (route) => false);
                },
                child: const BaseText('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return BaseInputField(
      controller: controller.newPasswordController,
      hintText: 'Password',
      isPasswordField: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your new password';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return BaseInputField(
      controller: controller.confirmNewPasswordController,
      hintText: 'Confirm Password',
      isPasswordField: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your new confirm password';
        }
        if (value != controller.newPasswordController.text) {
          return 'Password does not match';
        }
        return null;
      },
    );
  }
}
