import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_currency_text.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BasePriceRange extends StatelessWidget {
  final List<double> priceRange;
  final double fontSize;

  const BasePriceRange(this.priceRange, {super.key, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    if (priceRange[0] == priceRange[1]) {
      return BaseCurrencyText(
        priceRange[0],
        fontSize: fontSize,
      );
    }
    return Row(
      children: [
        BaseCurrencyText(priceRange[0], fontSize: fontSize),
        BaseText(
          ' - ',
          color: ColorConstants.red,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        BaseCurrencyText(priceRange[1], fontSize: fontSize),
      ],
    );
  }
}
