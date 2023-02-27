import 'package:fashion_shopping_app/core/models/response/ComputeOrder.dart';
import 'package:fashion_shopping_app/core/models/response/order_short.dart';
import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:fashion_shopping_app/core/repositories/discount_ticket_repository.dart';
import 'package:fashion_shopping_app/core/repositories/transaction_repository.dart';
import 'package:fashion_shopping_app/shared/enums/payment_method.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/request/order_create.dart';
import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/core/repositories/order_repository.dart';

class CheckoutController extends GetxController {
  final OrderRepository orderRepository;
  final AddressRepository addressRepository;
  final DiscountTicketRepository discountTicketRepository;
  final TransactionRepository transactionRepository;

  CheckoutController({
    required this.orderRepository,
    required this.addressRepository,
    required this.discountTicketRepository,
    required this.transactionRepository,
  });

  var isLoading = false.obs;
  var address = Rxn<Address>();
  var discountTickets = Rx<List<DiscountTicket>>([]);
  var selectedDiscountTicket = Rxn<DiscountTicket>();
  var selectedPaymentMethod = Rx<PaymentMethod>(PaymentMethod.cod);
  var computeOrder = Rxn<ComputeOrder>();

  List<CartItem> cartItems = [];
  // double subtotal = 0;

  // double? get discount {
  //   if (selectedDiscountTicket.value == null) return null;
  //   return (selectedDiscountTicket.value!.percent * subtotal / 100)
  //       .toPrecision(2);
  // }

  // double? get amount {
  //   if (discount == null) return subtotal;
  //   return (subtotal - discount!).toPrecision(2);
  // }

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    cartItems = Get.arguments;
    await fetchComputeOrder();
    await _getDefaultAddress();
    isLoading.value = false;
  }

  Future<void> _getDefaultAddress() async {
    final response =
        await addressRepository.getList(params: {'is_default': true});
    if (response != null && response.results.isNotEmpty) {
      address.value = response.results[0];
    }
  }

  Future<OrderShort?> createOrder() async {
    final response = await orderRepository.create(OrderCreate(
      orderItems: cartItems.map((e) => e.id).toList(),
      address: address.value!.id,
      discountTicket: selectedDiscountTicket.value?.id,
      paymentMethod: selectedPaymentMethod.value,
    ));
    return response;
  }

  Future<void> fetchTickets() async {
    final response =
        await discountTicketRepository.getList(params: {'is_saved': true});
    if (response != null) {
      discountTickets.value = response.results;
    }
  }

  Future<void> fetchComputeOrder() async {
    final response = await orderRepository.computeOrder(
        cartItems.map((e) => e.id).toList(), selectedDiscountTicket.value?.id);
    if (response != null) {
      computeOrder.value = response;
    }
  }
}
