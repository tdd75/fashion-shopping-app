import 'package:fashion_shopping_app/core/constants/color.dart';
import 'package:fashion_shopping_app/core/models/request/query_request.dart';
import 'package:fashion_shopping_app/core/widgets/icon/base_badge_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/core/widgets/rating_bar/base_rating_bar_indicator.dart';
import 'package:fashion_shopping_app/core/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/core/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/modules/home_tab/home_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: ColorConstants.secondary,
              title: _buildSearchBar(),
              actions: [
                BaseBadgeIcon(
                  number: 2,
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white),
                  onPressed: () => Get.toNamed(Routes.cart),
                ),
              ],
            )
          ],
          body: RefreshIndicator(
            onRefresh: () async {
              controller.query.value = QueryRequest();
              controller.fetchProducts();
            },
            child: _buildGridView(),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(),
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
              onPressed: () {},
            ),
          ),
          onFieldSubmitted: (value) {
            controller.query.value.search = value;
            controller.fetchProducts();
          }),
    );
  }

  Widget _buildGridView() {
    final products = controller.products.value ?? [];
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildCard(products[index]),
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
    );
  }

  Widget _buildCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.productDetail, arguments: product.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100,
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                imageUrl: product.image,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Image(image: AssetImage('assets/icons/logo.png')),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
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
                  const BaseCurrencyText(value: 5.55),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
