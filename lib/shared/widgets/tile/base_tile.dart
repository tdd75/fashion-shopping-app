import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/constants/color.dart';

class BaseTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const BaseTile({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Get.theme.copyWith(dividerColor: ColorConstants.transparent),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        child: ExpansionTile(
          title: title,
          initiallyExpanded: initiallyExpanded,
          children: children,
        ),
      ),
    );
  }
}
