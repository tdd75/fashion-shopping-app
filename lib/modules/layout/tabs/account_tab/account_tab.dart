import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/change_password_screen.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/setting_screen.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

class AccountTab extends GetView<AccountController> {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const BaseText('Account'),
        centerTitle: true,
      ),
      body: _buildButtonList(),
    );
  }

  Widget _buildButtonList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      children: [
        _buildActionsCard(),
        const SizedBox(height: 24),
        _buildButton(
          'Personal Information',
          const Icon(Icons.account_circle_outlined),
          () => Get.toNamed(Routes.userInfo),
        ),
        const SizedBox(height: 24),
        _buildButton('Change password', const Icon(Icons.lock_outlined),
            () => Get.to(const ChangePasswordScreen())),
        const SizedBox(height: 24),
        _buildButton('Settings', const Icon(Icons.settings_outlined),
            () => Get.to(const SettingScreen())),
        const SizedBox(height: 24),
        _buildButton('Support', const Icon(Icons.support_agent_outlined),
            () => Get.to(const SupportScreen())),
        const SizedBox(height: 24),
        _buildButton(
          'Logout',
          const Icon(Icons.logout_outlined),
          () => controller.logout(),
        ),
      ],
    );
  }

  Widget _buildButton(String text, Widget icon, Function() onPressed) {
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
            onTap: () => Get.toNamed(Routes.discountTicket),
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
