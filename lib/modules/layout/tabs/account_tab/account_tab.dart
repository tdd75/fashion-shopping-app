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
          title: const BaseText('Account'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: _buildActionsCard(),
            ),
          ]),
        ),
      );
    });
  }

  Container _buildActionsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.list_alt, size: 48),
                BaseText(
                  'Orders',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.confirmation_number_outlined, size: 48),
                BaseText(
                  'Tickets',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
