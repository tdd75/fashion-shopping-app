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

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  Product? get product => controller.product.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      if (product == null) return const NoItem();
      return Scaffold(
        appBar: AppBar(
          title: Text(product!.name),
          centerTitle: true,
          actions: [
            BaseBadgeIcon(
              number: 1,
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: ColorConstants.black,
              ),
              onPressed: () => Get.toNamed(Routes.cart),
            ),
          ],
        ),
        body: _buildBody(),
        bottomNavigationBar: Padding(
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
        ),
      );
    });
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
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
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [_buildProductInfo()],
          ),
        ),
      ],
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
          BasePriceRange(product!.priceRange, fontSize: 16),
          const SizedBox(height: 12),
          BaseTile(
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
        ],
      ),
    );
  }

  Widget _buildTypeSelect(
    List<String> allOptions,
    List<String> availableOptions,
    String? selected,
    Function(String value) onSelected,
  ) {
    return Wrap(
      spacing: 20,
      runSpacing: 12,
      children: List<Widget>.from(allOptions.map(
        (option) {
          final isSelected = option == selected;
          final isAvailable = availableOptions.contains(option);
          return GestureDetector(
            onTap: () {
              if (isAvailable) onSelected(option);
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 50),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? ColorConstants.lightGray
                      : isSelected
                          ? ColorConstants.white
                          : ColorConstants.darkGray,
                  border: Border.all(
                    width: 1.5,
                    color: isSelected
                        ? ColorConstants.primary
                        : ColorConstants.transparent,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(option, textAlign: TextAlign.center),
              ),
            ),
          );
        },
      )),
    );
  }

  void _showAddToCartPanel() {
    Get.bottomSheet(
      Obx(
        () => Wrap(
          children: [
            Padding(
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
                                    BaseCurrencyText(controller
                                        .selectedProductVariant!.price),
                                    BaseText(
                                        'Stock: ${controller.selectedProductVariant!.stocks}'),
                                  ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (product!.productVariants.length > 1) ...[
                    Divider(color: ColorConstants.darkGray),
                    BaseText(
                      'Colors',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.secondary,
                    ),
                    const SizedBox(height: 4),
                    _buildTypeSelect(
                      controller.allColors,
                      controller.availableColors,
                      controller.selectedColor.value,
                      controller.toggleColor,
                    ),
                    const SizedBox(height: 8),
                    BaseText(
                      'Sizes',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.secondary,
                    ),
                    const SizedBox(height: 4),
                    _buildTypeSelect(
                      controller.allSizes,
                      controller.availableSizes,
                      controller.selectedSize.value,
                      controller.toggleSize,
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
                      onPressed: () {
                        controller.addToCart();
                        Get.back();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: ColorConstants.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
