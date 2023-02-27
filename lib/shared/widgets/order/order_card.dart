import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final firstItem = order.orderItems[0];

    return InkWell(
      onTap: () => Get.toNamed(Routes.orderDetail, arguments: order.id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    firstItem.productVariant.product!.image,
                    height: 56,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseText(
                          firstItem.productVariant.product!.name,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                BaseText(
                                  '${firstItem.productVariant.color} - ${firstItem.productVariant.size}',
                                  color: Colors.grey,
                                ),
                                BaseText(
                                  'Quantity: ${firstItem.quantity}',
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            BaseCurrencyText(
                              firstItem.productVariant.price,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText('${order.orderItems.length} items'),
                  Row(
                    children: [
                      const BaseText('Total: '),
                      BaseCurrencyText(
                        order.amount,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                children: [
                  const BaseText('Code: ', fontSize: 16),
                  BaseText(
                    '#${order.code}',
                    fontSize: 16,
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
