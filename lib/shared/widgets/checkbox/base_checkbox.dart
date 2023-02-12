// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class BaseCheckbox extends StatelessWidget {
  final bool checked;
  final String? label;
  final Function(bool?)? onChecked;
  final CrossAxisAlignment crossAxisAlignment;

  const BaseCheckbox({
    super.key,
    required this.checked,
    this.label,
    this.onChecked,
    this.crossAxisAlignment = CrossAxisAlignment.center,
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
      crossAxisAlignment: crossAxisAlignment,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: checked,
            onChanged: _onChecked,
          ),
        ),
        const SizedBox(width: 4),
        if (label != null) Expanded(child: Text(label!)),
      ],
    );
  }
}
