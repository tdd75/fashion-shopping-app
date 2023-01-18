import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final ProductRepository productRepository;

  ProductDetailController({required this.productRepository});

  var product = Rxn<Product>();

  late int id;

  @override
  void onInit() {
    super.onInit();

    id = Get.arguments;
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    var response = await productRepository.get(id);
    if (response != null) {
      product.value = response;
      product.refresh();
    }
  }
}
