import 'package:fashion_shopping_app/core/models/request/cart_create.dart';
import 'package:fashion_shopping_app/core/models/request/product_favorite_update.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/models/response/product_variant.dart';
import 'package:fashion_shopping_app/core/models/response/review.dart';
import 'package:fashion_shopping_app/core/repositories/cart_repository.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:fashion_shopping_app/core/repositories/review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final ProductRepository productRepository;
  final CartRepository cartRepository;
  final ReviewRepository reviewRepository;

  ProductDetailController({
    required this.productRepository,
    required this.cartRepository,
    required this.reviewRepository,
  });

  var isLoading = false.obs;
  var product = Rxn<Product>();
  var newestReviews = Rx<List<Review>>([]);
  var relatedProducts = Rx<List<ProductShort>>([]);

  var reviews = Rx<List<Review>>([]);
  var selectedColor = Rxn<String>();
  var selectedSize = Rxn<String>();
  var quantityController = TextEditingController(text: '1');

  // Arguments
  late int id;

  // Review list
  final scrollController = ScrollController();
  var query = <String, dynamic>{
    'limit': 10,
    'offset': 0,
  };

  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    id = Get.arguments;
    scrollController.addListener(_triggerloadMore);
    await fetchProduct();
    await fetchNewestReviews();
    await fetchRelatedProducts();
    setDefaultType();
    isLoading.value = false;
  }

  @override
  void onClose() {
    scrollController.removeListener(_triggerloadMore);
    super.onClose();
  }

  Future<void> _triggerloadMore() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      query['offset'] = query['offset']! + query['limit']!;
      await fetchReviews();
    }
  }

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

  Future<void> fetchNewestReviews() async {
    final response = await reviewRepository.getList(id, params: {'limit': 3});
    if (response != null) {
      newestReviews.value = response.results;
    }
  }

  Future<void> fetchReviews() async {
    final response = await reviewRepository.getList(id, params: query);
    if (response != null) {
      reviews.value = response.results;
    }
  }

  Future<void> fetchRelatedProducts() async {
    final response = await productRepository.getRelatedProducts(id);
    if (response != null) {
      relatedProducts.value = response.results;
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
