import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/shared/constants/color.dart';

class BaseLoading extends StatelessWidget {
  const BaseLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          decoration: BoxDecoration(
            color: ColorConstants.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            spacing: 12,
            children: [
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(ColorConstants.primary),
              ),
              const BaseText(
                'Loading...',
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
