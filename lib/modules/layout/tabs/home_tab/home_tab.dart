import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/core/models/common/query_param.dart';
import 'package:fashion_shopping_app/shared/widgets/icon/base_badge_icon.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_price_range.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_shopping_app/core/models/response/product_short.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/widgets/rating_bar/base_rating_bar_indicator.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/home_tab/home_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  List<ProductShort> get products => controller.products.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            title: _buildSearchBar(),
            actions: [
              BaseBadgeIcon(
                number: 2,
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: ColorConstants.black,
                ),
                onPressed: () => Get.toNamed(Routes.cart),
              ),
            ],
          )
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            controller.query.value = QueryParam();
            await controller.fetchProducts(reset: true);
          },
          child: _buildGridView(),
        ),
      );
    });
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: ColorConstants.lightGray,
      ),
      child: TextFormField(
          controller: controller.searchController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'What are you looking for?',
            hintStyle: const TextStyle(color: Color(0xFFACACAC)),
            filled: true,
            suffixIcon: IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              color: ColorConstants.primary,
              onPressed: () => controller.loadMore(),
            ),
          ),
          onFieldSubmitted: (value) {
            controller.query.value.search = value;
            controller.fetchProducts();
          }),
    );
  }

  Widget _buildGridView() {
    return Obx(
      () => MasonryGridView.count(
        controller: controller.scrollController,
        crossAxisCount: 2,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildCard(products[index]),
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
    );
  }

  Widget _buildCard(ProductShort product) {
    return Card(
      child: InkWell(
        onTap: () => Get.toNamed(Routes.productDetail, arguments: product.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100, child: Image.network(product.image)),
            Container(
              height: 110,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseRatingBarIndicator(product.rating),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: BaseText(
                        product.name,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  BasePriceRange(product.priceRange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
