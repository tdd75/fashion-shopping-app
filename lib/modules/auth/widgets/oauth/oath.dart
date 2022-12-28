import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/modules/auth/widgets/oauth/button/facebook.dart';
import 'package:fashion_shopping_app/modules/auth/widgets/oauth/button/google.dart';

class Oauth extends StatelessWidget {
  const Oauth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Sign in with',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Google(),
            SizedBox(width: 12),
            Facebook(),
          ],
        ),
      ],
    );
  }
}
