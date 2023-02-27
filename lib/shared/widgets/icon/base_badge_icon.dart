import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseBadgeIcon extends StatelessWidget {
  final Icon icon;
  final int number;
  final Function() onPressed;

  const BaseBadgeIcon({
    super.key,
    required this.icon,
    required this.number,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
      child: Badge(
        isLabelVisible: number != 0,
        label: BaseText(number.toString(), color: ColorConstants.white),
        backgroundColor: ColorConstants.primary,
        child: IconButton(icon: icon, onPressed: onPressed),
      ),
    );
  }
}
