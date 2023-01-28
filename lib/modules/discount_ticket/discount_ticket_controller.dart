import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/core/repositories/discount_ticket_repository.dart';

class DiscountTicketController extends GetxController {
  final DiscountTicketRepository discountTicketRepository;

  DiscountTicketController({required this.discountTicketRepository});

  var isLoading = false.obs;
  var discountTickets = Rx<List<DiscountTicket>>([]);

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchTickets();
    isLoading.value = false;
  }

  Future<void> fetchTickets() async {
    final response = await discountTicketRepository.getList();
    if (response != null) {
      discountTickets.value = response.results;
    }
  }

  Future<bool> saveTicket(int id) async {
    return await discountTicketRepository.saveTicket(id);
  }
}
