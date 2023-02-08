import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/favorite_tab/favorite_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_price_range.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteTab extends GetView<FavoriteController> {
  const FavoriteTab({super.key});

  List<ProductShort> get favoritedProducts =>
      controller.favoritedProducts.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Favorite'),
        ),
        body: favoritedProducts.isEmpty
            ? const NoItem()
            : ListView.builder(
                itemCount: favoritedProducts.length,
                itemBuilder: (context, index) {
                  final product = favoritedProducts[index];
                  return ListTile(
                    leading: Image.network(product.image),
                    title: BaseText(product.name),
                    subtitle: BasePriceRange(product.priceRange),
                    trailing: InkWell(
                      onTap: () => controller.unfavorite(product.id),
                      child: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  );
                },
              ),
      );
    });
  }
}
