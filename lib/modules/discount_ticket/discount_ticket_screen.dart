import 'package:fashion_shopping_app/modules/order_detail/order_detail_controller.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/modules/discount_ticket/discount_ticket_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

class DiscountTicketScreen extends GetView<DiscountTicketController> {
  const DiscountTicketScreen({super.key});

  List<DiscountTicket>? get discountTickets => controller.discountTickets.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Discount Ticket'),
        ),
        body: _buildTicketList(),
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
    return GestureDetector(
      onTap: () {
        Get.find<OrderDetailController>().discountTicket.value = ticket;
        Get.back();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: ColorConstants.primary,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        color: ColorConstants.primary,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiscountValue(ticket.percent),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    'Get ${ticket.percent}% off with your order${ticket.minAmount != null ? ' (with minimum order \$${ticket.minAmount})' : ''}',
                    color: ColorConstants.white,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BaseText(
                        'Expiry: ${DateFormat('yyyy-MM-dd – kk:mm').format(ticket.endAt)}',
                        color: ColorConstants.white.withOpacity(0.6),
                      ),
                      InkWell(
                        onTap: () async {
                          final result = await controller.saveTicket(ticket.id);
                          if (result) {
                            Notify.success('Redeem successfully');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const BaseText(
                            'Redeem',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountValue(int value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: BaseText(
            '-$value%',
            fontSize: 16,
            color: ColorConstants.white,
          ),
        ),
        const SizedBox(width: 12),
        Wrap(
          direction: Axis.vertical,
          children: [
            BaseText(
              '$value% OFF',
              color: ColorConstants.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            BaseText('Discount', color: Colors.black45),
          ],
        ),
      ],
    );
  }
}
