import 'package:fashion_shopping_app/modules/auth/auth_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
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
            Image.asset('assets/icons/google.png'), controller.oauthGoogle),
        const SizedBox(width: 12),
        _buildOauthButton(
            Image.asset('assets/icons/facebook.png'), controller.oauthFacebook),
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.white,
            boxShadow: const [
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
