import 'package:fashion_shopping_app/core/models/request/cart_create.dart';
import 'package:fashion_shopping_app/core/models/request/product_favorite_update.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/models/response/product_variant.dart';
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
    return List<String>.from(product.value!.productVariants
        .map((productVariant) => productVariant.color)
        .toSet());
  }

  List<String> get allSizes {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productVariants
        .map((productVariant) => productVariant.size)
        .toSet());
  }

  List<String> get availableColors {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productVariants
        .where((productVariant) =>
            selectedSize.value == null ||
            productVariant.size == selectedSize.value &&
                productVariant.stocks > 0)
        .map((productVariant) => productVariant.color)
        .toSet());
  }

  List<String> get availableSizes {
    if (product.value == null) return [];
    return List<String>.from(product.value!.productVariants
        .where((productVariant) =>
            selectedColor.value == null ||
            productVariant.color == selectedColor.value &&
                productVariant.stocks > 0)
        .map((productVariant) => productVariant.size)
        .toSet());
  }

  ProductVariant? get selectedProductVariant {
    if (product.value == null) return null;
    return product.value!.productVariants.firstWhereOrNull((productVariant) =>
        productVariant.color == selectedColor.value &&
        productVariant.size == selectedSize.value);
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
    final productVariants = product.value?.productVariants;
    if (productVariants == null) return;
    if (productVariants.length == 1) {
      selectedColor.value = productVariants[0].color;
      selectedSize.value = productVariants[0].size;
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
        productVariantId: selectedProductVariant!.id,
      ),
    );
  }

  Future<void> updateFavorite() async {
    final targetProduct = product.value!;
    await productRepository.updateFavorite(
      targetProduct.id,
      ProductFavoriteUpdate(isFavorite: !targetProduct.isFavorite),
    );
    // update product in local
    final updatedProduct =
        targetProduct.copyWith(isFavorite: !targetProduct.isFavorite);
    product
      ..value = updatedProduct
      ..refresh();
  }
}
