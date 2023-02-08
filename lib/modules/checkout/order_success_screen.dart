import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessScreen extends StatelessWidget {
  final int orderId;
  final String orderCode;

  const OrderSuccessScreen({
    super.key,
    required this.orderId,
    required this.orderCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Success'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: ColorConstants.primary,
                    size: 48,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        'Order created successfully!',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 4),
                      Text.rich(TextSpan(
                        style: const TextStyle(color: Colors.black87),
                        children: [
                          const TextSpan(
                            text: 'Your order ',
                          ),
                          TextSpan(
                            text: '#$orderCode',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.primary,
                            ),
                          ),
                          const TextSpan(text: ' has been placed.'),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const BaseText(
                'Thank you for your order. We will notify you when your order is shipped.',
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BaseButton(
                text: 'View Order',
                onPressed: () {
                  Get.offNamed(Routes.orderDetail, arguments: orderId);
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 44),
                  side: BorderSide(color: ColorConstants.primary),
                ),
                child: const BaseText('Back to shopping', fontSize: 18),
                onPressed: () {
                  Get.offNamedUntil(Routes.layout, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
