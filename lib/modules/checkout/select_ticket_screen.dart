import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/modules/checkout/checkout_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

class SelectTicketScreen extends GetView<CheckoutController> {
  const SelectTicketScreen({super.key});

  List<DiscountTicket>? get discountTickets => controller.discountTickets.value;
  DiscountTicket? get selectedDiscountTicket =>
      controller.selectedDiscountTicket.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Select Ticket'),
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed(Routes.discountTicket);
              },
              child: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        body: discountTickets!.isNotEmpty ? _buildTicketList() : const NoItem(),
      );
    });
  }

  Widget _buildTicketList() {
    return ListView.builder(
      itemCount: discountTickets!.length,
      itemBuilder: (context, index) {
        var ticket = discountTickets![index];
        return _buildTicketTile(ticket);
      },
    );
  }

  Widget _buildTicketTile(DiscountTicket ticket) {
    return Obx(
      () => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: selectedDiscountTicket?.id == ticket.id,
        onChanged: (value) {
          controller.selectedDiscountTicket
            ..value = value! ? ticket : null
            ..refresh();
        },
        title: BaseText(
          'Get ${ticket.percent}% off${ticket.minAmount != null ? ' (minimum order: \$${ticket.minAmount})' : ''}',
          color: ColorConstants.success,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitle: BaseText(
          'Expiry: ${DateFormat('yyyy-MM-dd – kk:mm').format(ticket.endAt)}',
          color: Colors.black87.withOpacity(0.6),
        ),
      ),
    );
  }
}
