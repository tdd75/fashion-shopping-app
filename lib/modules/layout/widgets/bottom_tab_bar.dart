import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fashion_shopping_app/modules/layout/bloc/cubit/layout_cubit.dart';
import 'package:fashion_shopping_app/modules/layout/bloc/state/layout_state.dart';

class BottomTabBar extends StatelessWidget {
  final _tabBarData = [
    {
      'path': 'assets/icons/tab_bar/home.svg',
      'label': 'Home',
    },
    {
      'path': 'assets/icons/tab_bar/category.svg',
      'label': 'Category',
    },
    {
      'path': 'assets/icons/tab_bar/favorite.svg',
      'label': 'Favorite',
    },
    {
      'path': 'assets/icons/tab_bar/account.svg',
      'label': 'Account',
    },
  ];

  BottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) => AnimatedSwitcher(
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        duration: const Duration(milliseconds: 200),
        child: BottomNavigationBar(
          items: _tabBarData
              .map(
                (data) => BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    data['path']!,
                    height: 16,
                  ),
                  label: data['label'],
                ),
              )
              .toList(),
          currentIndex: state.tabIndex,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedItemColor: const Color(0xFFA4A4A4),
          onTap: (index) {
            context.read<LayoutCubit>().updateState(tabIndex: index);
          },
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
