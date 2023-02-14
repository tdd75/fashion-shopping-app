import 'dart:convert';

import 'package:fashion_shopping_app/core/models/request/user_update.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:fashion_shopping_app/core/repositories/user_repository.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoController extends GetxController {
  final UserRepository userRepository;
  final AddressRepository addressRepository;

  UserInfoController({
    required this.userRepository,
    required this.addressRepository,
  });

  var isLoading = false.obs;
  var user = Rxn<User>();
  final address = Rxn<Address>();

  final infoFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchUserInfo();
    await fetchDefaultAddress();
    isLoading.value = false;
  }

  Future<void> fetchUserInfo() async {
    user.value = await userRepository.getInfo();
    firstNameController.text = user.value!.firstName;
    lastNameController.text = user.value!.lastName;
    if (user.value!.phone != null) {
      phoneController.text = user.value!.phone!;
    }
  }

  Future<void> fetchDefaultAddress() async {
    final response =
        await addressRepository.getList(params: {'is_default': true});
    if (response != null) {
      if (response.results.isNotEmpty) {
        address.value = response.results.first;
      }
    }
  }

  Future<void> updateInfo() async {
    if (infoFormKey.currentState!.validate()) {
      final reponse = await userRepository.updateInfo(UserUpdate(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
      ));
      if (reponse != null) {
        user.value = reponse;
        Get.back();
        Notify.success('Update info successfully');
      }
    }
  }

  Future<void> updateAvatar(XFile imageFile) async {
    final data = await imageFile.readAsBytes();
    final encodedData = base64Encode(data);

    final reponse = await userRepository.updateInfo(UserUpdate(
      avatar: encodedData,
    ));
    if (reponse != null) {
      user.value = reponse;
    }
  }
}
