import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String label;
  final VoidCallback? action;
  final double? height;
  final double? width;

  const BaseButton(
    this.label, {
    super.key,
    required this.action,
    this.height = 42,
    this.width = 196,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
