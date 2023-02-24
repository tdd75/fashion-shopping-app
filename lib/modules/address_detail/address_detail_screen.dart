import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/modules/address/address_controller.dart';
import 'package:fashion_shopping_app/modules/address_detail/address_detail_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
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
          actions: [
            if (controller.id != null)
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: ColorConstants.error,
                ),
                onPressed: () async {
                  await controller.deleteAddress();
                  Get.find<AddressController>()
                    ..fetchAddresses()
                    ..addresses.refresh();
                },
              ),
          ],
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
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
                },
              ),
            ],
          ),
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
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Full name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.phoneController,
          hintText: 'Phone',
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Phone is required';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'City is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.districtController,
          hintText: 'District',
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'District is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.wardController,
          hintText: 'Ward',
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Ward is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        BaseInputField(
          controller: controller.detailController,
          hintText: 'Detail',
          validator: (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Detail is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
