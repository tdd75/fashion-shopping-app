import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fashion_shopping_app/core/constants/tabs.dart';
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Account",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: "Resource",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: "Resource",
          // ),
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return controller.homeTab;
      // case MainTabs.discover:
      //   return controller.discoverTab;
      // case MainTabs.resource:
      //   return controller.resourceTab;
      case MainTabs.inbox:
        return controller.inboxTab;
      case MainTabs.me:
        return controller.accountTab;
      default:
        return controller.homeTab;
    }
  }
}
