import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/core/models/response/list_response.dart';
import 'package:fashion_shopping_app/core/repositories/cart_repository.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;

  CartController({required this.cartRepository});

  var cartItems = Rxn<ListResponse<CartItem>>();

  late int id;

  @override
  void onInit() {
    super.onInit();

    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    var response = await cartRepository.getList();
    if (response!.results.isNotEmpty) {
      cartItems.value = response;
      cartItems.refresh();
    }
  }
}
