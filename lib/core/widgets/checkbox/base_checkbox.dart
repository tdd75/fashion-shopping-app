// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fashion_shopping_app/core/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class BaseCheckbox extends StatelessWidget {
  final bool checked;
  final String? label;
  final Function(bool?)? onChecked;

  const BaseCheckbox({
    super.key,
    required this.checked,
    this.label,
    this.onChecked,
  });

  void _onChecked(bool? checked) {
    checked = checked;
    if (onChecked != null) {
      onChecked!(checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24.0,
          height: 24.0,
          child: Checkbox(
            value: checked,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: _onChecked,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: BaseText(label!, textAlign: TextAlign.left, fontSize: 13.0),
        ),
      ],
    );
  }
}
