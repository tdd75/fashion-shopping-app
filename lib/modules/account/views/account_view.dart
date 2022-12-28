import 'package:fashion_shopping_app/core/widgets/base_button.dart';
import 'package:fashion_shopping_app/modules/auth/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseButton('Logout', action: () async => _triggerLogout(context)),
    );
  }

  // private methods
  Future<void> _triggerLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access');
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(WelcomeView.routeName);
  }
}
