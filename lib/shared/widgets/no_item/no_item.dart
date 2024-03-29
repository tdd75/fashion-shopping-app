import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  const NoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 32),
                Text('No items found'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
