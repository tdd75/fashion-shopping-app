import 'package:fashion_shopping_app/core/models/request/address_create.dart';
import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/address.dart';

class AddressDetailController extends GetxController {
  final AddressRepository addressRepository;

  AddressDetailController({required this.addressRepository});

  var isLoading = false.obs;
  var address = Rxn<Address>();
  var isDefault = false.obs;

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final wardController = TextEditingController();
  final detailController = TextEditingController();

  late int? id;

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    id = Get.arguments;
    await fetchAddress();
    isLoading.value = false;
  }

  Future<void> fetchAddress() async {
    if (id == null) return;
    final response = await addressRepository.get(id!);
    if (response != null) {
      address.value = response;
      fullNameController.text = address.value!.fullName;
      phoneController.text = address.value!.phone;
      cityController.text = address.value!.city;
      districtController.text = address.value!.district;
      wardController.text = address.value!.ward;
      detailController.text = address.value!.detail;
      isDefault.value = address.value!.isDefault;
    }
  }

  Future<void> saveAddress() async {
    if (formKey.currentState!.validate() == false) return;
    final saveData = AddressCreate(
      fullName: fullNameController.text,
      phone: phoneController.text,
      city: cityController.text,
      district: districtController.text,
      ward: wardController.text,
      detail: detailController.text,
      isDefault: isDefault.value,
    );
    if (id == null) {
      await addressRepository.create(saveData);
      Get.back();
      Notify.success('Create address successfully');
    } else {
      await addressRepository.update(id!, saveData);
      Get.back();
      Notify.success('Update address successfully');
    }
  }

  Future<void> deleteAddress() async {
    if (id == null) return;
    final result = await addressRepository.delete(id!);
    if (result) {
      Get.back();
    }
  }
}
