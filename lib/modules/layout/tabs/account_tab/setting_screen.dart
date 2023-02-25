import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends GetView<AccountController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BaseText(
                'Discount notification',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              Switch(
                onChanged: (value) {
                  controller.discountNotification.value = value;
                  controller.toggleDiscountNotification();
                },
                value: controller.discountNotification.value,
                activeColor: ColorConstants.primary,
              ),
            ],
          ),
        ),
      );
    });
  }
}
