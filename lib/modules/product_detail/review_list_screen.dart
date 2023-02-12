import 'package:fashion_shopping_app/modules/product_detail/product_detail_controller.dart';
import 'package:fashion_shopping_app/shared/widgets/reviews/review_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewListScreen extends GetView<ProductDetailController> {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Obx(() => SingleChildScrollView(
            controller: controller.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (final review in controller.reviews.value)
                    ReviewItem(review: review),
                ],
              ),
            ),
          )),
    );
  }
}
