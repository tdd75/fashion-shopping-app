import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BaseRatingBarIndicator extends StatelessWidget {
  final double rating;
  final double size;

  const BaseRatingBarIndicator(
    this.rating, {
    super.key,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemCount: 5,
      direction: Axis.horizontal,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: size,
    );
  }
}
