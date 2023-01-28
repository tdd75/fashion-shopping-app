import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseCurrencyText extends StatelessWidget {
  final double value;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;

  const BaseCurrencyText(
    this.value, {
    super.key,
    this.color = Colors.red,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      '\$$value',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
