import 'package:fashion_shopping_app/modules/account/views/account_view.dart';
import 'package:fashion_shopping_app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_shopping_app/modules/layout/bloc/cubit/layout_cubit.dart';
import 'package:fashion_shopping_app/modules/layout/bloc/state/layout_state.dart';
import 'package:fashion_shopping_app/modules/layout/widgets/bottom_tab_bar.dart';

class LayoutView extends StatelessWidget {
  static const routeName = '/layout';

  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) => IndexedStack(
          index: state.tabIndex,
          children: [
            const HomeView(),
            Container(),
            Container(),
            const AccountView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(),
    );
  }
}
