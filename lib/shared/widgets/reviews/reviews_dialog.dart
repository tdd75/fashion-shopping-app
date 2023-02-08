import 'package:fashion_shopping_app/core/models/response/cart_item.dart';
import 'package:fashion_shopping_app/shared/widgets/order/order_item.dart';
import 'package:fashion_shopping_app/shared/widgets/rating_bar/base_rating_bar.dart';
import 'package:flutter/material.dart';

class ReviewsDialog extends StatelessWidget {
  final Function(double rating) onChangeRating;
  final TextEditingController? controller;
  final Function() onSubmit;
  final CartItem cartItem;

  const ReviewsDialog({
    super.key,
    required this.onChangeRating,
    this.controller,
    required this.onSubmit,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          OrderItemCard(cartItem: cartItem, isShort: true),
          const SizedBox(height: 10),
          BaseRatingBar(onChanged: onChangeRating),
          const SizedBox(height: 10),
          const Text('Write your review'),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Write your review',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              onSubmit();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
