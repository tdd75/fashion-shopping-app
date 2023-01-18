import 'package:flutter/material.dart';

class BaseInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool? isPasswordField;
  final String? Function(String?)? validator;

  const BaseInputField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.isPasswordField = false,
    this.validator,
  });

  @override
  State<BaseInputField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseInputField> {
  bool _passwordVisible = false;

  final _borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent),
  );

  @override
  void initState() {
    _passwordVisible = false;
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
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          focusedBorder: _borderStyle,
          disabledBorder: _borderStyle,
          errorBorder: _borderStyle,
          focusedErrorBorder: _borderStyle,
          enabledBorder: _borderStyle,
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPasswordField!
              ? GestureDetector(
                  child: _passwordVisible
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.visibility))
                      : const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.visibility_off)),
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
        ),
        obscureText: widget.isPasswordField! ? !_passwordVisible : false,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
