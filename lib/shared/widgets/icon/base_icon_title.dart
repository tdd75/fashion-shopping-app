import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseIconTitle extends StatelessWidget {
  const BaseIconTitle({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.backgroundColor = Colors.transparent,
    this.paddingTop = 8,
    this.padingBottom = 8,
    this.paddingLeft = 16,
    this.paddingRight = 32,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.drawablePadding = 10,
  });

  final Function() onTap;
  final Widget icon;
  final String title;
  final Color backgroundColor;

  final double paddingLeft, paddingTop, paddingRight, padingBottom;
  final double marginLeft, marginTop, marginRight, marginBottom;
  final double drawablePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
      child: Material(
        borderRadius: BorderRadius.circular(11),
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                paddingLeft, paddingTop, paddingRight, padingBottom),
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: drawablePadding,
                ),
                Expanded(
                    child: BaseText(
                  title,
                  color: ColorConstants.darkGray,
                  fontSize: 16,
                )),
                Icon(
                  Icons.chevron_right,
                  color: ColorConstants.darkGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
