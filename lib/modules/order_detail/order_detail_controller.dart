import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/request/order_create.dart';
import 'package:fashion_shopping_app/core/models/response/address.dart';
import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/discount_ticket.dart';
import 'package:fashion_shopping_app/core/models/response/order.dart';
import 'package:fashion_shopping_app/core/repositories/address_repository.dart';
import 'package:fashion_shopping_app/core/repositories/order_repository.dart';

class OrderDetailController extends GetxController {
  final OrderRepository orderRepository;
  final AddressRepository addressRepository;

  OrderDetailController({
    required this.orderRepository,
    required this.addressRepository,
  });

  var isLoading = false.obs;
  var order = Rxn<Order>();
  var address = Rxn<Address>();
  var discountTicket = Rxn<DiscountTicket>();

  late int? id;
  List<CartItem> cartItems = [];
  double subtotal = 0;

  double? get discount {
    if (discountTicket.value == null) return null;
    return (discountTicket.value!.percent * subtotal / 100).toPrecision(2);
  }

  double? get amount {
    if (discount == null) return subtotal;
    return (subtotal - discount!).toPrecision(2);
  }

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    id = Get.arguments['id'];
    await fetchOrder();
    cartItems = Get.arguments['cartItems'];
    subtotal = Get.arguments['totalPrice'];
    await _getDefaultAddress();
    isLoading.value = false;
  }

  Future<void> fetchOrder() async {
    if (id == null) return;
    final response = await orderRepository.get(id!);
    if (response != null) {
      order.value = response;
    }
  }

  Future<void> _getDefaultAddress() async {
    if (id != null) return;
    final response =
        await addressRepository.getList(params: {'is_default': true});
    if (response != null && response.results.isNotEmpty) {
      address.value = response.results[0];
    }
  }

  Future<bool?> createOrder() async {
    final response = await orderRepository.create(OrderCreate(
      cartItems: cartItems.map((e) => e.id).toList(),
      address: address.value!.id,
      discountTicket: discountTicket.value?.id,
    ));
    return response;
  }
}
