import 'package:flutter/material.dart';

class OauthButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;

  const OauthButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: IconButton(
        onPressed: () => onPressed(),
        icon: Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.161),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: icon,
        ),
      ),
    );
  }
}
