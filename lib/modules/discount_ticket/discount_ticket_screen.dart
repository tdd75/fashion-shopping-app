import 'package:fashion_shopping_app/modules/checkout/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fashion_shopping_app/shared/enums/discount_ticket_tabs.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/modules/discount_ticket/discount_ticket_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

class DiscountTicketScreen extends GetView<DiscountTicketController> {
  const DiscountTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return WillPopScope(
        onWillPop: () async {
          try {
            Get.find<CheckoutController>().fetchTickets();
          } catch (e) {
            // ignore: avoid_print
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Discount Ticket'),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: ColorConstants.primary,
              controller: controller.tabController,
              tabs: DiscountTicketTabs.values
                  .map((e) => Tab(text: e.title))
                  .toList(),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: [
              _buildTicketList(controller.newestDiscountTickets.value, false),
              _buildTicketList(controller.savedDiscountTickets.value, true),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTicketList(List<DiscountTicket> tickets, bool isSaved) {
    if (tickets.isEmpty) return const NoItem();
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        var ticket = tickets[index];
        return _buildTicketTile(ticket, isSaved);
      },
    );
  }

  Widget _buildTicketTile(DiscountTicket ticket, bool isSaved) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: ColorConstants.primary,
        ),
        borderRadius: BorderRadius.circular(15),
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
                    if (!isSaved)
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
            const BaseText('Discount', color: Colors.black45),
          ],
        ),
      ],
    );
  }
}
