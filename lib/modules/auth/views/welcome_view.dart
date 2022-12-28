import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/modules/auth/widgets/oauth/oath.dart';
import 'package:fashion_shopping_app/core/widgets/base_button.dart';

class WelcomeView extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'FASHION SHOPPING APP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'Fashion Shopping App is a smart shopping app'
                    'with integrated image search and chatbot for better shopping experience.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              BaseButton('Login', width: 228, action: () {}),
              const SizedBox(height: 8),
              BaseButton('Register now', width: 228, action: () {
                // context.read<AuthCubit>().updateViewContent(ViewContent.register);
              }),
              const SizedBox(height: 16),
              const Oauth(),
              const SizedBox(height: 16),
            ],
          )
        ],
      ),
    );
  }
}
