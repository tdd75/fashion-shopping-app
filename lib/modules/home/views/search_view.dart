import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/modules/home/widgets/header/search_bar_input.dart';

class SearchView extends StatelessWidget {
  static const routeName = '/home/search';

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [SearchBarInput()],
        body: Column(children: [Text('as')]),
      ),
    );
  }
}
