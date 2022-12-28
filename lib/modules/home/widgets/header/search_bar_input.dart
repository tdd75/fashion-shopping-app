import 'package:flutter/material.dart';

class SearchBarInput extends StatelessWidget {
  final TextEditingController _filter = TextEditingController();

  SearchBarInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 26),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: TextFormField(
                controller: _filter,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'What are you looking for?',
                  hintStyle: const TextStyle(color: Color(0xFFACACAC)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
