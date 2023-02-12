// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:get/get.dart';

class VariantOption {
  final String label;
  final dynamic value;

  VariantOption({
    required this.label,
    required this.value,
  });
}

class VariantSelect extends StatelessWidget {
  final List<VariantOption> allOptions;
  final List<VariantOption> availableOptions;
  final dynamic selected;
  final Function(dynamic value) onSelected;

  const VariantSelect({
    super.key,
    required this.allOptions,
    required this.availableOptions,
    this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 12,
      children: List<Widget>.from(allOptions.map(
        (option) {
          final isSelected = option.value == selected;
          final isAvailable = availableOptions.firstWhereOrNull(
                  (element) => element.value == option.value) !=
              null;
          return GestureDetector(
            onTap: () {
              if (isAvailable) onSelected(option.value);
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 50),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? ColorConstants.lightGray
                      : isSelected
                          ? ColorConstants.white
                          : ColorConstants.darkGray,
                  border: Border.all(
                    width: 1.5,
                    color: isSelected
                        ? ColorConstants.primary
                        : ColorConstants.transparent,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(option.label, textAlign: TextAlign.center),
              ),
            ),
          );
        },
      )),
    );
  }
}
