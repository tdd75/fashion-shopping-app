import 'package:fashion_shopping_app/core/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseCurrencyText extends StatelessWidget {
  final double value;
  final double fontSize;

  const BaseCurrencyText({super.key, required this.value, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      '\$$value',
      color: Colors.red,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }
}
