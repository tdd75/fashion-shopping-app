import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BaseCarousel extends StatelessWidget {
  final List<Widget> items;
  final double? height;

  const BaseCarousel({
    super.key,
    required this.items,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        reverse: false,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
