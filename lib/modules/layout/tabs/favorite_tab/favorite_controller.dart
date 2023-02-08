import 'package:fashion_shopping_app/core/models/request/product_favorite_update.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/repositories/product_repository.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final ProductRepository productRepository;

  FavoriteController({
    required this.productRepository,
  });

  var isLoading = false.obs;
  var favoritedProducts = Rx<List<ProductShort>>([]);

  @override
  void onInit() async {
    isLoading.value = true;
    super.onInit();

    await fetchFavoritedProducts();
    isLoading.value = false;
  }

  Future<void> fetchFavoritedProducts() async {
    final response =
        await productRepository.getList(params: {'is_favorite': true});
    if (response != null) {
      favoritedProducts.value = response.results;
    }
  }

  Future<void> unfavorite(int id) async {
    final result = await productRepository.updateFavorite(
        id, ProductFavoriteUpdate(isFavorite: false));
    if (result) {
      favoritedProducts.value.removeWhere((element) => element.id == id);
      favoritedProducts.refresh();
    }
  }
}
