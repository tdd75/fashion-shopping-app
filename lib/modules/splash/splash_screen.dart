import 'package:fashion_shopping_app/core/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 128, vertical: 16),
            child: Image.asset('assets/icons/logo.png'),
          ),
          const BaseText(
            'Fashion Shopping App',
            fontSize: 24,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
