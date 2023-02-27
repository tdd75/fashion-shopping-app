import 'package:fashion_shopping_app/modules/cart/cart_controller.dart';
import 'package:fashion_shopping_app/modules/product_detail/review_list_screen.dart';
import 'package:fashion_shopping_app/shared/widgets/product/product_card.dart';
import 'package:fashion_shopping_app/shared/widgets/reviews/review_item.dart';
import 'package:fashion_shopping_app/shared/widgets/variant_select/variant_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/models/response/product.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/carousel/base_carousel.dart';
import 'package:fashion_shopping_app/shared/widgets/form/base_input_quantity.dart';
import 'package:fashion_shopping_app/shared/widgets/image/preview_image.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/no_item/no_item.dart';
import 'package:fashion_shopping_app/shared/widgets/rating_bar/base_rating_bar_indicator.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_price_range.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/shared/widgets/tile/base_tile.dart';
import 'package:fashion_shopping_app/core/routes/app_pages.dart';
import 'package:fashion_shopping_app/shared/widgets/icon/base_badge_icon.dart';
import 'package:fashion_shopping_app/modules/product_detail/product_detail_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailController controller;

  Product? get product => controller.product.value;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(builder: (controller) {
      this.controller = controller;
      return Obx(() {
        if (controller.isLoading.value) return const BaseLoading();
        if (product == null) return const NoItem();
        return Scaffold(
          appBar: AppBar(
            title: Text(product!.name),
            centerTitle: true,
            actions: [
              Obx(() => BaseBadgeIcon(
                    number: Get.find<CartController>().cartItems.value.length,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorConstants.black,
                    ),
                    onPressed: () => Get.toNamed(Routes.cart),
                  )),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [_buildProductInfo()],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomBar(),
        );
      });
    });
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.grey[750],
      ),
      automaticallyImplyLeading: false,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: ColorConstants.white,
          child: BaseCarousel(
            items: [
              PreviewImage(product!.image),
              PreviewImage(product!.image),
              PreviewImage(product!.image),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: BaseButton(
              text: 'Place order',
              onPressed: _showAddToCartPanel,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              product!.isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 32,
              color: ColorConstants.red,
            ),
            onPressed: () => controller.updateFavorite(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                children: [
                  BaseRatingBarIndicator(product!.rating),
                  Text(
                    '${product!.reviewCount} reviews',
                    style: const TextStyle(color: Color(0xFF979797)),
                  ),
                ],
              ),
              product!.stocks > 0
                  ? const Text('In Stock',
                      style: TextStyle(color: Color(0xFF03A600)))
                  : const Text('Out of Stock',
                      style: TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product!.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BasePriceRange(product!.priceRange, fontSize: 16),
              BaseText(product!.category.name),
            ],
          ),
          const SizedBox(height: 12),
          BaseTile(
            initiallyExpanded: true,
            title: const BaseText(
              'Description',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: [
              BaseText(product!.description),
            ],
          ),
          const SizedBox(height: 12),
          _buildReviewList(),
          const SizedBox(height: 12),
          _buildRelatedProducts(),
        ],
      ),
    );
  }

  Widget _buildReviewList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText(
            'Reviews',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
          controller.newestReviews.value.isEmpty
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorConstants.lightGray,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const BaseText(
                    'No reviews yet for this product',
                    textAlign: TextAlign.center,
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      'Reviews',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.fetchReviews();
                        Get.to(() => const ReviewListScreen());
                      },
                      child: BaseText(
                        'See all',
                        color: ColorConstants.primary,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 12),
          Column(
            children: [
              for (final review in controller.newestReviews.value)
                ReviewItem(review: review),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddToCartPanel() {
    Get.bottomSheet(
      Obx(() => Wrap(children: [_buildCartPanel()])),
      backgroundColor: ColorConstants.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildCartPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 96,
            child: Row(
              children: [
                PreviewImage(product!.image),
                const SizedBox(width: 12),
                Wrap(
                  spacing: 4,
                  direction: Axis.vertical,
                  children: [
                    ...(controller.selectedProductVariant == null
                        ? [
                            BasePriceRange(product!.priceRange),
                            BaseText('Stock: ${product!.stocks}'),
                          ]
                        : [
                            BaseCurrencyText(
                                controller.selectedProductVariant!.price),
                            BaseText(
                                'Stock: ${controller.selectedProductVariant!.stocks}'),
                          ]),
                  ],
                ),
              ],
            ),
          ),
          ...[
            Divider(color: ColorConstants.darkGray),
            BaseText(
              'Colors',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.secondary,
            ),
            const SizedBox(height: 4),
            VariantSelect(
              allOptions: controller.allColors
                  .map((e) => VariantOption(label: e, value: e))
                  .toList(),
              availableOptions: controller.availableColors
                  .map((e) => VariantOption(label: e, value: e))
                  .toList(),
              selected: controller.selectedColor.value,
              onSelected: (value) => controller.selectedColor.value = value,
            ),
            const SizedBox(height: 8),
            BaseText(
              'Sizes',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.secondary,
            ),
            const SizedBox(height: 4),
            VariantSelect(
              allOptions: controller.allSizes
                  .map((e) => VariantOption(label: e, value: e))
                  .toList(),
              availableOptions: controller.availableSizes
                  .map((e) => VariantOption(label: e, value: e))
                  .toList(),
              selected: controller.selectedSize.value,
              onSelected: (value) => controller.selectedSize.value = value,
            ),
            const SizedBox(height: 4),
          ],
          Divider(color: ColorConstants.darkGray),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                'Quantity',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstants.primary,
              ),
              BaseInputQuantity(
                controller: controller.quantityController,
                maxValue: controller.selectedProductVariant?.stocks ??
                    product!.stocks,
              ),
            ],
          ),
          const SizedBox(height: 12),
          BaseButton(
              text: 'Add to cart',
              onPressed: () async {
                await controller.addToCart();
                final cartController = Get.find<CartController>();
                await cartController.fetchCartItems();
                cartController.cartItems.refresh();
                Get.back();
              }),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText(
          'Related products',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.relatedProducts.value.length,
            itemBuilder: (context, index) {
              final product = controller.relatedProducts.value[index];
              return ProductCard(product: product);
            },
          ),
        ),
      ],
    );
  }
}
