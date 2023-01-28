import 'package:fashion_shopping_app/core/models/request/cart_create.dart';
import 'package:fashion_shopping_app/core/models/request/product_update_favorite.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/models/response/product_type.dart';
import 'package:fashion_shopping_app/core/repositories/cart_repository.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final ProductRepository productRepository;
  final CartRepository cartRepository;

  ProductDetailController({
    required this.productRepository,
    required this.cartRepository,
  });

  var isLoading = false.obs;
  var product = Rxn<Product>();
  var selectedColor = Rxn<String>();
  var selectedSize = Rxn<String>();
  var quantityController = TextEditingController(text: '1');

  late int id;

  List<String> get allColors {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productTypes
        .map((productType) => productType.color)
        .toSet());
  }

  List<String> get allSizes {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productTypes
        .map((productType) => productType.size)
        .toSet());
  }

  List<String> get availableColors {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productTypes
        .where((productType) =>
            selectedSize.value == null ||
            productType.size == selectedSize.value && productType.stocks > 0)
        .map((productType) => productType.color)
        .toSet());
  }

  List<String> get availableSizes {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productTypes
        .where((productType) =>
            selectedColor.value == null ||
            productType.color == selectedColor.value && productType.stocks > 0)
        .map((productType) => productType.size)
        .toSet());
  }

  ProductType? get selectedProductType {
    if (product.value == null) return null;
    return product.value!.productTypes.firstWhereOrNull((productType) =>
        productType.color == selectedColor.value &&
        productType.size == selectedSize.value);
  }

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    id = Get.arguments;
    await fetchProduct();
    setDefaultType();
    isLoading.value = false;
  }

  void toggleColor(String color) {
    if (selectedColor.value == color) {
      selectedColor.value = null;
    } else {
      selectedColor.value = color;
    }
  }

  void toggleSize(String size) {
    if (selectedSize.value == size) {
      selectedSize.value = null;
    } else {
      selectedSize.value = size;
    }
  }

  void setDefaultType() {
    final productTypes = product.value?.productTypes;
    if (productTypes == null) return;
    if (productTypes.length == 1) {
      selectedColor.value = productTypes[0].color;
      selectedSize.value = productTypes[0].size;
    }
  }

  Future<void> fetchProduct() async {
    final response = await productRepository.get(id);
    if (response != null) {
      product.value = response;
    }
  }

  Future<void> addToCart() async {
    await cartRepository.create(
      CartCreate(
        quantity: int.tryParse(quantityController.text) ?? 1,
        productTypeId: selectedProductType!.id,
      ),
    );
  }

  Future<void> updateFavorite() async {
    final targetProduct = product.value!;
    await productRepository.updateFavorite(
      targetProduct.id,
      ProductUpdateFavorite(isFavorite: !targetProduct.isFavorite),
    );
    // update product in local
    final updatedProduct =
        targetProduct.copyWith(isFavorite: !targetProduct.isFavorite);
    product
      ..value = updatedProduct
      ..refresh();
  }
}
