import 'package:fashion_shopping_app/modules/home/widgets/header/search_bar.dart';
import 'package:fashion_shopping_app/modules/home/widgets/product_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [SearchBar()],
      body: const ProductList(),
    );
  }
}
