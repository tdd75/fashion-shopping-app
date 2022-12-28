import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/modules/home/views/search_view.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      pinned: true,
      title: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 44,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(SearchView.routeName),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.search,
                  color: Color(0xFFACACAC),
                ),
                SizedBox(width: 8),
                Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFACACAC),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
