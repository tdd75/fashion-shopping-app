import 'package:fashion_shopping_app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OauthButtons extends StatelessWidget {
  final controller = Get.find<AuthController>();

  OauthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOauthButton(
          Image.asset('assets/icons/google.png'),
          () => controller.oauthGoogle(),
        ),
        const SizedBox(width: 12),
        _buildOauthButton(
          Image.asset('assets/icons/facebook.png'),
          () {},
        ),
      ],
    );
  }

  Widget _buildOauthButton(Widget icon, Function onPressed) {
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
