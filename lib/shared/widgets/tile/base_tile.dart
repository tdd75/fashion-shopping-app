import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/constants/color.dart';

class BaseTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  const BaseTile({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Get.theme.copyWith(dividerColor: ColorConstants.transparent),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        child: ExpansionTile(title: title, children: children),
      ),
    );
  }
}
