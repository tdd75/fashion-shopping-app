import 'package:fashion_shopping_app/shared/widgets/button/base_button.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportScreen extends StatelessWidget {
  final hotline = '0123456789';
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const BaseText(
              'If you have any questions, please contact us',
              fontSize: 16,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 240,
              child: BaseButton(
                text: 'Hotline: $hotline',
                onPressed: () async {
                  final url = 'tel:$hotline';
                  await launchUrlString(url);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
