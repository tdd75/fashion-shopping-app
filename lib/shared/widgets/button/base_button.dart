import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double fontSize;
  final Color? color;

  const BaseButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 18,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? ColorConstants.primary,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        splashColor: Colors.greenAccent,
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 80),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Center(
                child: BaseText(
                  text,
                  color: ColorConstants.white,
                  fontSize: fontSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
