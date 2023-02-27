import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:flutter/material.dart';

class BaseInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  final bool readOnly;
  final String? initialValue;

  const BaseInputField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.isPasswordField = false,
    this.validator,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  State<BaseInputField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseInputField> {
  late bool _obsecureText;
  final _borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent),
  );

  @override
  void initState() {
    _obsecureText = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      color: Colors.transparent,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        obscureText: _obsecureText,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textAlignVertical: TextAlignVertical.center,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          focusedBorder: _borderStyle,
          disabledBorder: _borderStyle,
          errorBorder: _borderStyle,
          focusedErrorBorder: _borderStyle,
          enabledBorder: _borderStyle,
          border: _borderStyle,
          hintText: widget.hintText,
          filled: true,
          fillColor:
              widget.readOnly ? ColorConstants.darkGray : ColorConstants.white,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  child: _obsecureText
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.visibility_off),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.visibility)),
                  onTap: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
