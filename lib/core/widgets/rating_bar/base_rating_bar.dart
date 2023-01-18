import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BaseRatingBar extends StatelessWidget {
  final Function(double)? onChanged;

  const BaseRatingBar({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      itemCount: 5,
      direction: Axis.horizontal,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onChanged ?? (rating) {},
    );
  }
}
