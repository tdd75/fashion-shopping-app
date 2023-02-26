import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/enums/layout_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Icons.favorite,
              color: ColorConstants.primary,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.smart_toy_sharp,
              color: ColorConstants.primary,
            ),
            label: 'Bot',
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

  Widget _buildContent(LayoutTabs tab) {
    switch (tab) {
      case LayoutTabs.home:
        return controller.homeTab;
      case LayoutTabs.favorite:
        return controller.favoriteTab;
      case LayoutTabs.chatbot:
        return controller.chatbotTab;
      case LayoutTabs.inbox:
        return controller.inboxTab;
      case LayoutTabs.me:
        return controller.accountTab;
      default:
        return controller.homeTab;
    }
  }
}
