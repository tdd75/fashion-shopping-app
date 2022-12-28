import 'package:fashion_shopping_app/core/helper.dart';
import 'package:fashion_shopping_app/modules/layout/views/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_shopping_app/modules/auth/bloc/cubit/login_cubit.dart';
import 'package:fashion_shopping_app/modules/auth/widgets/oauth/button/oauth_button.dart';

class Google extends StatelessWidget {
  const Google({super.key});

  @override
  Widget build(BuildContext context) {
    return OauthButton(
      onPressed: () => _onLoginGoogle(context),
      icon: Image.asset('assets/icons/auth/google.png'),
    );
  }

  // private methods
  void _onLoginGoogle(BuildContext context) async {
    final response = await context.read<LoginCubit>().loginGoogle();
    if (response.error == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(LayoutView.routeName);
    } else {
      // ignore: use_build_context_synchronously
      Helper.showSnackBar(context, response.error!);
    }
  }
}
