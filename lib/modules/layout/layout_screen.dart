import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/shared/constants/tabs.dart';
import 'package:fashion_shopping_app/modules/layout/layout_controller.dart';

class LayoutScreen extends GetView<LayoutController> {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: ColorConstants.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: ColorConstants.primary,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: ColorConstants.primary,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: ColorConstants.primary,
            ),
            label: 'Account',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        selectedItemColor: ColorConstants.primary,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(Tabs tab) {
    switch (tab) {
      case Tabs.home:
        return controller.homeTab;
      case Tabs.inbox:
        return controller.inboxTab;
      case Tabs.me:
        return controller.accountTab;
      case Tabs.favorite:
        return controller.favoriteTab;
      default:
        return controller.homeTab;
    }
  }
}
