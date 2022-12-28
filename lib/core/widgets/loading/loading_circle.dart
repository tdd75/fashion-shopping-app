import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(16),
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
