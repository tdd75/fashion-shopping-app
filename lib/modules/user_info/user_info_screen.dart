import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/user_info/user_info_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/address/address_card.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_field.dart';
import 'package:fashion_shopping_app/shared/widgets/image_picker/base_image_picker.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends GetView<UserInfoController> {
  const UserInfoScreen({super.key});

  Address? get address => controller.address.value;
  User get user => controller.user.value!;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Information'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => controller.updateInfo(),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildAvatar(),
            const SizedBox(height: 32),
            _buildInfo(),
            const SizedBox(height: 12),
            _buildAddress(),
          ],
        ),
      );
    });
  }

  Widget _buildAvatar() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 64,
            backgroundImage: NetworkImage(
              controller.user.value?.avatar ??
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
            ),
          ),
          const SizedBox(height: 12),
          Positioned(
            top: -12,
            right: -12,
            child: BaseImagePicker(
              onPicked: (file) {
                if (file != null) controller.updateAvatar(file);
              },
              icon: Icon(Icons.edit, color: ColorConstants.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Form(
      key: controller.infoFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText(
            'Your Information',
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 12),
          _buildUsername(),
          const SizedBox(height: 12),
          _buildEmail(),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFirstName(),
              const SizedBox(width: 12),
              _buildLastName(),
            ],
          ),
          const SizedBox(height: 12),
          _buildPhone(),
        ],
      ),
    );
  }

  Widget _buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText('Phone', color: Colors.black87),
        const SizedBox(height: 4),
        BaseInputField(
          controller: controller.phoneController,
          hintText: 'Phone',
        ),
      ],
    );
  }

  Widget _buildLastName() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText('Last name', color: Colors.black87),
          const SizedBox(height: 4),
          BaseInputField(
            controller: controller.lastNameController,
            hintText: 'Last name',
          ),
        ],
      ),
    );
  }

  Widget _buildFirstName() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText('First name', color: Colors.black87),
          const SizedBox(height: 4),
          BaseInputField(
            controller: controller.firstNameController,
            hintText: 'First name',
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText('Email', color: Colors.black87),
        const SizedBox(height: 4),
        BaseInputField(
          hintText: 'Email',
          readOnly: true,
          initialValue: user.email,
        ),
      ],
    );
  }

  Widget _buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText('Username', color: Colors.black87),
        const SizedBox(height: 4),
        BaseInputField(
          hintText: 'Username',
          readOnly: true,
          initialValue: user.username,
        ),
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
                margin: const EdgeInsets.only(top: 12),
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
