import 'package:fashion_shopping_app/modules/layout/tabs/home_tab/home_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/range_slider/base_range_slider.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:fashion_shopping_app/shared/widgets/variant_select/variant_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends GetView<HomeController> {
  const FilterScreen({super.key});

  List<double> get priceRange => controller.filter.value!.priceRange;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.query.addAll(controller.initQuery);
        await controller.fetchProducts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Filter'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 20),
          children: [
            _buildPriceRange(),
            const SizedBox(height: 24),
            _buildCategories(),
            const SizedBox(height: 24),
            _buildColors(),
            const SizedBox(height: 24),
            _buildSizes(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: BaseText(
            'Price Range',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        BaseRangeSlider(
          initRange: [
            controller.query['min_price'] ?? priceRange[0],
            controller.query['max_price'] ?? priceRange[1],
          ],
          min: priceRange[0],
          max: priceRange[1],
          onChanged: (start, end) {
            controller.query['min_price'] = start.toPrecision(2);
            controller.query['max_price'] = end.toPrecision(2);
          },
        ),
      ],
    );
  }

  Widget _buildColors() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText(
            'Colors',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 12),
          Obx(() => VariantSelect(
                allOptions: controller.filter.value!.colors
                    .map((e) => VariantOption(label: e, value: e))
                    .toList(),
                availableOptions: controller.filter.value!.colors
                    .map((e) => VariantOption(label: e, value: e))
                    .toList(),
                selected: controller.query['color'],
                onSelected: (value) {
                  if (controller.query['color'] == value) {
                    controller.query['color'] = null;
                  } else {
                    controller.query['color'] = value;
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildSizes() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText(
            'Sizes',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 12),
          Obx(() => VariantSelect(
                allOptions: controller.filter.value!.sizes
                    .map((e) => VariantOption(label: e, value: e))
                    .toList(),
                availableOptions: controller.filter.value!.sizes
                    .map((e) => VariantOption(label: e, value: e))
                    .toList(),
                selected: controller.query['size'],
                onSelected: (value) {
                  if (controller.query['size'] == value) {
                    controller.query['size'] = null;
                  } else {
                    controller.query['size'] = value;
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseText(
            'Categories',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SizedBox(height: 12),
          Obx(() => VariantSelect(
                allOptions: controller.filter.value!.categories
                    .map((e) => VariantOption(label: e.name, value: e.name))
                    .toList(),
                availableOptions: controller.filter.value!.categories
                    .map((e) => VariantOption(label: e.name, value: e.name))
                    .toList(),
                selected: controller.query['category'],
                onSelected: (value) {
                  if (controller.query['category'] == value) {
                    controller.query['category'] = null;
                  } else {
                    controller.query['category'] = value;
                  }
                },
              )),
        ],
      ),
    );
  }
}
