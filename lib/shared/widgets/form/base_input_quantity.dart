import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:flutter/material.dart';

class BaseInputQuantity extends StatelessWidget {
  final TextEditingController controller;
  final int maxValue;
  final Function? onChanged;

  const BaseInputQuantity({
    super.key,
    required this.controller,
    required this.maxValue,
    this.onChanged,
  });

  int getSafeValue(int? value) {
    if (value == null || value <= 0) {
      return 1;
    } else if (value >= maxValue) {
      return maxValue;
    }
    return value;
  }

  void updateQuantity(int value) {
    final safeValue = getSafeValue(value);
    controller.value = TextEditingValue(
      text: safeValue.toString(),
      selection: TextSelection.collapsed(offset: safeValue.toString().length),
    );

    if (onChanged != null) {
      onChanged!(safeValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _getOperatorButton(() {
          final value = int.tryParse(controller.text);
          if (value != null) {
            updateQuantity(value - 1);
          }
        }, const Icon(Icons.remove)),
        SizedBox(
          width: 40,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            onFieldSubmitted: (value) {
              updateQuantity(int.tryParse(value) ?? 1);
            },
          ),
        ),
        _getOperatorButton(() {
          final value = int.tryParse(controller.text);
          if (value != null) {
            updateQuantity(value + 1);
          }
        }, const Icon(Icons.add)),
      ],
    );
  }

  Widget _getOperatorButton(Function() onTap, Widget icon) {
    return InkWell(
      focusColor: ColorConstants.red,
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: icon,
      ),
    );
  }
}
