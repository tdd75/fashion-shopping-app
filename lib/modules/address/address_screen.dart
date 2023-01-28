import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/address/address_controller.dart';
import 'package:fashion_shopping_app/modules/order_detail/order_detail_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
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
    return ListView.builder(
      itemCount: addresses!.length,
      itemBuilder: (context, index) {
        var address = addresses![index];
        return _buildAddressTile(address);
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
          Get.find<OrderDetailController>().address
            ..value = address
            ..refresh();
          Get.back();
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
          child: Icon(Icons.edit, color: ColorConstants.primary, size: 18),
        ),
      ),
    );
  }
}
