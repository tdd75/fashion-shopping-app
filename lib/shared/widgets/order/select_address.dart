import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class AddressInfo extends StatelessWidget {
  final Address? address;

  const AddressInfo({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.lightGray,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.location_on, color: ColorConstants.primary),
        title: const BaseText(
          'Delivery Address',
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        subtitle: address != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  BaseText('${address!.fullName} | ${address!.phone}'),
                  BaseText(address!.detail),
                  BaseText(
                    '${address!.ward}, ${address!.district}, ${address!.city}',
                  ),
                ],
              )
            : const BaseText('Add new address'),
      ),
    );
  }
}
