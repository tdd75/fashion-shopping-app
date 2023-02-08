import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

class AccountTab extends GetView<AccountController> {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const BaseText('Account'),
          centerTitle: true,
        ),
        body: _buildButtonList(),
      );
    });
  }

  Widget _buildButtonList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      children: [
        _buildActionsCard(),
        const SizedBox(height: 24),
        _buildButton(const Icon(Icons.account_circle_outlined),
            'Personal Information', () {}),
        const SizedBox(height: 24),
        _buildButton(const Icon(Icons.privacy_tip_outlined), 'Privacy', () {}),
        const SizedBox(height: 24),
        _buildButton(const Icon(Icons.lock_outlined), 'Change password', () {}),
        const SizedBox(height: 24),
        _buildButton(const Icon(Icons.settings_outlined), 'Settings', () {}),
        const SizedBox(height: 24),
        _buildButton(const Icon(Icons.logout_outlined), 'Logout', () {
          controller.logout();
        }),
      ],
    );
  }

  Widget _buildButton(Widget icon, String text, Function() onPressed) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.lightGray,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                icon,
                const SizedBox(width: 12),
                BaseText(
                  text,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildActionsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: ColorConstants.lightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.order),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.list_alt,
                  size: 48,
                  color: ColorConstants.secondary,
                ),
                BaseText(
                  'Orders',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: ColorConstants.secondary,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.confirmation_number_outlined,
                  size: 48,
                  color: ColorConstants.secondary,
                ),
                BaseText(
                  'Tickets',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: ColorConstants.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
