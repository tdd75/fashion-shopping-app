import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/address/address_card.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateInformation extends GetView<AccountController> {
  const UpdateInformation({super.key});

  Address? get address => controller.address.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Update Information'),
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildInfo(),
            const SizedBox(height: 12),
            _buildAddress(),
          ],
        ),
      );
    });
  }

  Widget _buildInfo() {
    return Column(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundImage: NetworkImage(
            controller.user.value?.avatar ??
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          ),
        ),
        BaseButton(text: 'Upload picture', onPressed: () {
          
        }),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BaseText(
              'Address',
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            GestureDetector(
                onTap: () => Get.toNamed(Routes.address),
                child: BaseText(
                  'Edit',
                  color: ColorConstants.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
          ],
        ),
        address != null
            ? AddressCard(address: address!, showLabel: false)
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(color: ColorConstants.lightGray),
                child: const BaseText(
                  'You have not added an default address yet',
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }
}
