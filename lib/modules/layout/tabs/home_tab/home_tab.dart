import 'package:fashion_shopping_app/modules/layout/tabs/home_tab/filter_screen.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/enums/order_options.dart';
import 'package:fashion_shopping_app/shared/widgets/icon/base_badge_icon.dart';
import 'package:fashion_shopping_app/shared/widgets/image_picker/base_image_picker.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_price_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  Map<String, dynamic> get query => controller.query;

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
            controller.resetQuery();
            await controller.fetchProducts();
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
          suffixIcon: BaseImagePicker(
            child: const Icon(Icons.camera_alt_outlined),
            onPicked: (file) async {
              if (file == null) return;
              EasyLoading.show();
              await controller.searchByImage(file);
              EasyLoading.dismiss();
            },
          ),
        ),
        onFieldSubmitted: (value) {
          controller.query['search'] = value;
          controller.fetchProducts();
        },
      ),
    );
  }

  Widget _buildGridView() {
    return Obx(
      () => ListView(
        controller: controller.scrollController,
        children: [
          _buildFilterBar(),
          products.isEmpty
              ? Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      SizedBox(height: 128),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 32),
                          Text('No items found'),
                        ],
                      ),
                    ],
                  ),
                )
              : MasonryGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCard(products[index]);
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                await controller.getFilter();
                Get.to(const FilterScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: ColorConstants.lightGray),
                child: const Wrap(
                  spacing: 4,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.filter_alt),
                    BaseText('Filter', color: Colors.black87)
                  ],
                ),
              ),
            ),
          ),
          Obx(() => Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(color: ColorConstants.lightGray),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87),
                        value: query['ordering'],
                        hint: const Text('Order by'),
                        icon: const Icon(Icons.sort),
                        items:
                            List<DropdownMenuItem>.from(SortOptions.values.map(
                          (opt) => DropdownMenuItem(
                            value: opt.value,
                            child: Text(opt.title),
                          ),
                        )),
                        onChanged: (value) async {
                          controller.query['ordering'] = value;
                          await controller.fetchProducts();
                        },
                      ),
                    ),
                  ),
                ),
              )),
        ],
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
