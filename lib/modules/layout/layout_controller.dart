import 'package:get/get.dart';

import 'package:fashion_shopping_app/modules/layout/tabs/favorite_tab/favorite_tab.dart';
import 'package:fashion_shopping_app/shared/constants/tabs.dart';
import 'package:fashion_shopping_app/core/models/response/user.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/home_tab/home_tab.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/inbox_tab/inbox_tab.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/account_tab/account_tab.dart';

class LayoutController extends GetxController {
  LayoutController();

  var currentTab = Tabs.home.obs;
  var user = Rxn<User>();

  late HomeTab homeTab;
  late InboxTab inboxTab;
  late FavoriteTab favoriteTab;
  late AccountTab accountTab;

  @override
  void onInit() {
    super.onInit();

    homeTab = const HomeTab();
    inboxTab = const InboxTab();
    favoriteTab = const FavoriteTab();
    accountTab = const AccountTab();
  }

  void switchTab(index) {
    var tab = Tabs.values[index];
    currentTab.value = tab;
  }

  int getCurrentIndex(Tabs tab) {
    return tab.index;
  }
}
