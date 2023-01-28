import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final Widget? child;
  final Color? color;
  final double width;
  final double height;
  final void Function()? onPressed;

  const BaseButton({
    super.key,
    this.text = "",
    this.child,
    this.color,
    this.width = double.infinity,
    this.height = 44,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? ColorConstants.primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadow,
            offset: const Offset(0, 1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onTap: onPressed,
          child: Center(
            child: text != ""
                ? BaseText(
                    text,
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
