import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/address/address_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});

  List<Address>? get addresses => controller.addresses.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Address'),
        ),
        body: _buildAddressList(),
      );
    });
  }

  Widget _buildAddressList() {
    if (addresses!.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Icon(Icons.location_pin, size: 64),
            const SizedBox(height: 16),
            const BaseText('No address found'),
            const SizedBox(height: 16),
            SizedBox(
              width: 220,
              child: BaseButton(
                text: 'Create an address',
                onPressed: () => Get.toNamed(Routes.addressDetail),
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: addresses!.length + 1,
      itemBuilder: (context, index) {
        if (index == addresses!.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: BaseButton(
              text: 'Add new address',
              onPressed: () => Get.toNamed(Routes.addressDetail),
            ),
          );
        }
        return _buildAddressTile(addresses![index]);
      },
    );
  }

  Widget _buildAddressTile(Address address) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorConstants.darkGray),
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.location_pin),
        contentPadding: const EdgeInsets.all(12),
        onTap: () {
          // Get.find<OrderDetailController>().address
          //   ..value = address
          //   ..refresh();
          // Get.back();
        },
        title: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            BaseText('${address.fullName} | ${address.phone}'),
            if (address.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorConstants.success,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: BaseText(
                  'Default',
                  fontSize: 12,
                  color: ColorConstants.white,
                ),
              )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            BaseText(address.detail),
            BaseText(
              '${address.ward}, ${address.district}, ${address.city}',
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () => Get.toNamed(Routes.addressDetail, arguments: address.id),
          child: Icon(Icons.edit, color: ColorConstants.primary, size: 24),
        ),
      ),
    );
  }
}
