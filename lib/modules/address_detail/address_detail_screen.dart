import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/modules/address/address_controller.dart';
import 'package:fashion_shopping_app/modules/address_detail/address_detail_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/checkbox/base_checkbox.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressDetailScreen extends GetView<AddressDetailController> {
  const AddressDetailScreen({super.key});

  Address? get address => controller.address.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.id != null ? 'Edit Address' : 'Create Address',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          children: [
            _buildContact(),
            const SizedBox(height: 24),
            _buildAddress(),
            const SizedBox(height: 16),
            BaseCheckbox(
              checked: controller.isDefault.value,
              onChecked: (value) {
                controller.isDefault.value = value!;
              },
              label: 'Set as default address',
            ),
            const SizedBox(height: 16),
            BaseButton(
              text: 'Save',
              onPressed: () async {
                await controller.saveAddress();
                Get.find<AddressController>()
                  ..fetchAddresses()
                  ..addresses.refresh();

                Get.back();
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText('Contact', fontSize: 16),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.fullNameController,
          hintText: 'Full Name',
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.phoneController,
          hintText: 'Phone',
        ),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText('Address', fontSize: 16),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.cityController,
          hintText: 'City',
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.districtController,
          hintText: 'District',
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.wardController,
          hintText: 'Ward',
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.detailController,
          hintText: 'Detail',
        ),
      ],
    );
  }
}
