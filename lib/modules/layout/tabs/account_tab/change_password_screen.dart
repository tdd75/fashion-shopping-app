import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:fashion_shopping_app/shared/constants/common.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends GetView<AccountController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Form(
            key: controller.changePasswordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOldPassword(),
                const SizedBox(height: 16),
                _buildNewPassword(),
                const SizedBox(height: 16),
                _buildConfirmNewPassword(),
                const SizedBox(height: 32),
                BaseButton(
                    text: 'Change password',
                    onPressed: () async {
                      final result = await controller.changePassword();
                      if (result == true) {
                        Notify.success('Password changed successfully');
                        Get.back();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmNewPassword() {
    return BaseInputField(
      controller: controller.confirmNewPasswordController,
      hintText: 'Cofirm New Password',
      isPasswordField: true,
      validator: (p0) {
        if (p0 != controller.newPasswordController.text) {
          return 'Password does not match';
        }
        return null;
      },
    );
  }

  Widget _buildNewPassword() {
    return BaseInputField(
      controller: controller.newPasswordController,
      hintText: 'New Password',
      isPasswordField: true,
      validator: (p0) {
        if (p0!.length < CommonConstants.passwordMinLength) {
          return 'Password must be at least ${CommonConstants.passwordMinLength} characters';
        }
        return null;
      },
    );
  }

  Widget _buildOldPassword() {
    return BaseInputField(
      controller: controller.oldPasswordController,
      hintText: 'Old Password',
      isPasswordField: true,
      validator: (p0) {
        if (p0!.length < CommonConstants.passwordMinLength) {
          return 'Password must be at least ${CommonConstants.passwordMinLength} characters';
        }
        return null;
      },
    );
  }
}
