import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class BaseBadgeIcon extends StatelessWidget {
  final Icon icon;
  final int number;
  final VoidCallback onPressed;

  const BaseBadgeIcon({
    super.key,
    required this.icon,
    required this.number,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Badge(
        position: BadgePosition.topEnd(top: 0, end: 0),
        badgeContent: number != 0
            ? BaseText(number.toString(), color: ColorConstants.white)
            : const SizedBox(),
        badgeColor: ColorConstants.primary,
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
