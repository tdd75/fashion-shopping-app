import 'package:fashion_shopping_app/core/helper.dart';
import 'package:fashion_shopping_app/modules/layout/views/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_shopping_app/modules/auth/bloc/cubit/login_cubit.dart';
import 'package:fashion_shopping_app/modules/auth/widgets/oauth/button/oauth_button.dart';

class Facebook extends StatelessWidget {
  const Facebook({super.key});

  @override
  Widget build(BuildContext context) {
    return OauthButton(
      onPressed: () => _onLoginFacebook(context),
      icon: Image.asset('assets/icons/auth/facebook.png'),
    );
  }

  // private methods
  void _onLoginFacebook(BuildContext context) async {
    final response = await context.read<LoginCubit>().loginFacebook();
    if (response.error == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(LayoutView.routeName);
    } else {
      // ignore: use_build_context_synchronously
      Helper.showSnackBar(context, response.error!);
    }
  }
}
