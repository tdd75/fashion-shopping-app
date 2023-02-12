// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fashion_shopping_app/shared/widgets/rating_bar/base_rating_bar_indicator.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/core/models/response/review.dart';

class ReviewItem extends StatelessWidget {
  final Review review;

  const ReviewItem({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            foregroundImage: NetworkImage(review.owner.avatar ??
                'https://reqres.in/img/faces/2-image.jpg'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.owner.fullName.trim().isEmpty
                          ? 'No name'
                          : review.owner.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    BaseRatingBarIndicator(review.rating),
                  ],
                ),
                const SizedBox(height: 2),
                BaseText(
                  '${review.variant.color} - ${review.variant.size}',
                  color: Colors.grey,
                  fontSize: 12,
                ),
                const SizedBox(height: 8),
                Text(review.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
