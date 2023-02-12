import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  final bool showLabel;
  const AddressCard({
    super.key,
    required this.address,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          const BaseText(
            'Delivery Address',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        const SizedBox(height: 8),
        Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstants.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    BaseText('${address.fullName} | ${address.phone}'),
                    BaseText(address.detail),
                    BaseText(
                      '${address.ward}, ${address.district}, ${address.city}',
                    ),
                  ],
                )
              ],
            )),
      ],
    );
  }
}
